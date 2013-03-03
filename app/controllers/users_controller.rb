class UsersController < ApplicationController
  def index
    @users = User.near([current_user.latitude, current_user.longitude], 100)
  end
end
