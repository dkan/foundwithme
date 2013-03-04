class UsersController < ApplicationController
  def index
    @users = User.near([current_user.latitude, current_user.longitude], 100)
    if params[:query]
      Logger.new(STDOUT).info params[:query]
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
