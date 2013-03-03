module ApplicationHelper
  def skills_for (user)
    user.user_skills.includes(:skill).map do |us|
      { id: us.skill.id, name: us.skill.name }
    end
  end
  def body_class
    [controller_name, action_name].join('-')
  end
end
