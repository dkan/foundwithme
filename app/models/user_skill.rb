class UserSkill < ActiveRecord::Base
  attr_accessible :skill_id, :user_id
  
  belongs_to :skill
  belongs_to :user
end
