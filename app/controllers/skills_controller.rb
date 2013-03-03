class SkillsController < ApplicationController
  before_filter :get_skill
  
  def index
    @user = current_user

    respond_to do |format|
      format.json
      format.html
    end
  end

  def show
    respond_to do |format|
      if @skill.present?
        format.json { render json: @skill, status: :ok }
      else
Rails.logger.debug 'hi'
        format.json { render status: :error, message: 'Skill not found' }
      end
    end
  end
  
  def import
    session[:"user_return_to"] = skills_path

    respond_to do |format|
      format.json
      format.html { redirect_to user_omniauth_authorize_path(:linkedin) }
    end
  end

  private

  def get_skill
    @skill = Skill.find(params[:id])
  end
end
