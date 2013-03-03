class SkillsController < ApplicationController
  
  def index
    @user = current_user
  end
  
  def import
    session[:"user_return_to"] = skills_path
    redirect_to user_omniauth_authorize_path(:linkedin)
  end
end
