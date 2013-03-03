class SkillsController < ApplicationController
  
  def index
    @user = current_user

    respond_to do |format|
      format.json
      format.html
    end
  end
  
  def import
    session[:"user_return_to"] = skills_path

    respond_to do |format|
      format.json
      format.html { redirect_to user_omniauth_authorize_path(:linkedin) }
    end
  end
end
