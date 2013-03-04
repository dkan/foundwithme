class SkillsController < ApplicationController
  before_filter :get_skill, except: [:search]
  
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
        format.json { render json: 'Skill not found', status: :error }
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

  def search
    @skills = Skill.where(['name like ?', "#{params[:skill_name].downcase}%"])
    respond_to do |format|
      format.json { render json: @skills, status: :ok }
    end
  end

  private

  def get_skill
    @skill = Skill.find(params[:skill_id]) rescue nil
  end
end
