module ApplicationHelper
  def skills_for (user)
    user.user_skills.includes(:skill).map do |us|
      { id: us.skill.id, name: us.skill.name }
    end
  end
  
  def employments_for (user)
    user.employments.map do |emp|
      { id: emp.id, company: emp.company, title: emp.title, start_date: emp.start_date, end_date: emp.end_date }
    end
  end
  
  def educations_for (user)
    user.educations.map do |edu|
      { id: edu.id, degree: edu.degree, institution: edu.institution, start_date: edu.start_date, end_date: edu.end_date }
    end
  end
end
