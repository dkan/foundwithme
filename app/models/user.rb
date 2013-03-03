class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :location, :first_name, :last_name

  validates_presence_of :first_name, :last_name
  has_many :authentications
  has_many :user_skills

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
    update_linkedin_info(omniauth)
  end
  
  def update_linkedin_info(omniauth)
    # Remove old info
    self.user_skills.destroy_all
    
    build_skills(omniauth)
  end
  
  def build_skills(omniauth)
    skills = Skill.get_skill_ids_from_omniauth(omniauth)
    skills.each do |skill| 
      self.user_skills.build(skill_id: skill)
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
