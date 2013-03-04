class UserSkill < ActiveRecord::Base
  attr_accessible :skill_id, :user_id
  
  belongs_to :skill
  belongs_to :user
  
  def self.update_user_skills (user_id, skill_ids, new_skill_list)
    ids = skill_ids || []
    
    if new_skill_list
      new_skill_list.each do |s|
        ids << Skill.find_or_create_by_name(s.downcase).id
      end
    end
    
    user = User.find(user_id)
    user.user_skills = []
    ids.each do |id| 
      user.user_skills.build(skill_id: id)
    end
    
    user.save!
  end
end
