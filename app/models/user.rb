class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :location, :first_name, :last_name, :educations_attributes, :employments_attributes

  validates_presence_of :first_name, :last_name
  has_many :authentications
  has_many :user_skills
  has_many :user_interests
  has_many :educations
  has_many :employments
  
  accepts_nested_attributes_for :educations, :allow_destroy => true
  accepts_nested_attributes_for :employments, :allow_destroy => true

  geocoded_by :location

  after_validation :geocode

  # Used by Devise in case there was an error saving the user with oauth
  def self.new_with_session(params, session)
    auth_info = session["devise.user_attributes"]
    super.tap do |user|
      if auth_info
        user.attr_from_omniauth(auth_info)

        user.valid?
      end
    end
  end

  def create_omniauth(omniauth)
    self.authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
    update_linkedin_info(omniauth, :all)
  end
  
  # Only update when mode is passed
  def update_linkedin_info(omniauth, mode=nil)
    case mode
      when :skills
        build_skills(omniauth)
      when :education
        build_education(omniauth)
      when :employment
        build_employment(omniauth)
      when :all
        build_skills(omniauth)
        build_education(omniauth)
        build_employment(omniauth)
        build_interests(omniauth)
    end
  end
  
  def update_linkedin_info!(omniauth, mode=nil)
    self.update_linkedin_info(omniauth, mode)
    self.save!
  end
  
  def build_skills(omniauth)
    skills = Skill.get_ids_from_omniauth(omniauth)
    
    new_skills = skills - self.user_skills.map(&:skill_id) 
    new_skills.each do |skill| 
      self.user_skills.build(skill_id: skill)
    end
  end
  
  def build_interests(omniauth)
    ids = Interest.get_ids_from_omniauth(omniauth)
    
    new_interests = ids - self.user_interests.map(&:interest_id) 
    new_interests.each do |id| 
      self.user_interests.build(interest_id: id)
    end
  end
  
  def build_education(omniauth)
    educations = omniauth.extra.raw_info.educations
    if educations._total > 0
      
      educations.values[1].each do |edu|
        education = self.educations.find_or_initialize_by_institution(edu['schoolName'])
        education.degree = edu['degree']
        if !education.degree.blank? && !edu['fieldOfStudy'].blank?
          education.degree += ", " + edu['fieldOfStudy']
        else
          education.degree = edu['fieldOfStudy']
        end
        
        education.start_date = edu['startDate'].nil? ? nil : edu['startDate']['year'].to_s + '-01-01'
        education.end_date = edu['endDate'].nil? ? nil : edu['endDate']['year'].to_s + '-01-01'
      end
    end
  end
  
  def build_employment(omniauth)
    positions = omniauth.extra.raw_info.positions
    if positions._total > 0
      
      positions.values[1].each do |pos|
        
        position = self.employments.find_or_initialize_by_company(pos['company']["name"])
        position.title = pos['title']
        position.start_date = pos['startDate'].nil? ? nil : pos['startDate']['year'].to_s+'-01-01'
        position.end_date = pos['endDate'].nil? ? nil : pos['endDate']['year'].to_s+'-01-01'
      end
    end
  end
  
  def attr_from_omniauth(auth_info)
    self.first_name ||= auth_info.info.first_name
    self.last_name ||= auth_info.info.last_name
    self.email = (self.email.blank?) ? auth_info.info.email : self.email
    self.password = Devise.friendly_token[0,20]
    self.create_omniauth(auth_info)

    self
  end
end
