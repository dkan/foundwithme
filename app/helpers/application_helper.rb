module ApplicationHelper
  def skills_for (user)
    user.user_skills.includes(:skill).map do |us|
      { id: us.skill.id, name: us.skill.name }
    end
  end
  
  def interests_for (user)
    user.user_interests.includes(:interest).map do |us|
      { id: us.interest.id, name: us.interest.name }
    end
  end
  
  def body_class
    [controller_name, action_name].join('-')
  end
end
