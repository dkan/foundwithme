class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
      session[:"user_return_to"].nil? ? "/" : session[:"user_return_to"].to_s
  end

  def index
  end
end
