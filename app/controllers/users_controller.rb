class UsersController < ApplicationController
  def index
    if params[:query]
      @users = User.near(params[:query][:location], 100)
      @users = @users.where(milestone: params[:query][:milestones]) if params[:query][:milestones]
      @users = @users.where(status: params[:query][:statuses]) if params[:query][:statuses]
      @users = @users.where(role: params[:query][:roles]) if params[:query][:roles]
      @users = @users.where(looking_for: params[:query][:lookingFor]) if params[:query][:lookingFor]
    else
      @users = User.near([current_user.latitude, current_user.longitude], 100)
    end

    respond_to do |format|
      format.json { render json: @users, status: :ok }

      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render json: 'User updated.', status: :ok }
      else
        format.json { render json: 'Unable to update user.', status: :error }
      end 
    end
  end

  def profile
    @user = current_user
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
