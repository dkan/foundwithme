class Skill < ActiveRecord::Base
  attr_accessible :name
  
  def self.get_ids_from_omniauth(omniauth)
    
    ids = []
    skill_list = omniauth.extra.raw_info.skills
    
    if skill_list._total > 0

      skill_list = skill_list.values[1]
      skill_list.each do |s|
        ids << self.find_or_create_by_name(s.skill.name.downcase).id
      end
    end

    ids
  end
end
