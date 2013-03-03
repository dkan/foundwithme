class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :location

  has_many :authentications

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

  def apply_omniauth(omniauth)
    self.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def attr_from_omniauth(auth_info)
    #self.first_name ||= auth_info.info.first_name
    #self.last_name ||= auth_info.info.last_name
    self.email = (self.email.blank?) ? auth_info.info.email : self.email
    self.password = Devise.friendly_token[0,20]
    self.apply_omniauth(auth_info)

    self
  end

end
