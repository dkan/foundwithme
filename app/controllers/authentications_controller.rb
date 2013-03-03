class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    #raise omniauth.to_yaml
    
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      authentication.user.update_linkedin_info(omniauth)
      authentication.user.save!
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user 
      current_user.create_omniauth(omniauth)
      current_user.save!
      redirect_to after_sign_in_path_for(current_user)
    else
      user = User.new
      user.attr_from_omniauth(omniauth)
      user.location = "#{request.location.city}, #{request.location.state}"

      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session["devise.user_attributes"] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy
    redirect_to profile_path
  end
  
  def failure
    redirect_to root_path, :flash => {:error => "Could not log you in. #{params[:message]}"}
  end
  
  alias_method :linkedin, :create
end
