class UsersController < ApplicationController
  def index
    @users = User.near([current_user.latitude, current_user.longitude], 100)
    if params[:query]
      Logger.new(STDOUT).info params[:query]
    end
    respond_to do |format|
      format.html

      format.json {
        render json: (
          @users
        )
      }
    end
  end
end
