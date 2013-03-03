class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if authentication
      mode = get_sync_mode(omniauth, authentication)
      authentication.user.update_linkedin_info!(omniauth, mode)
      if mode == :all
        authentication.update_attributes!({last_synced: Time.now().to_i})
      end
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
  
  private
  
  def get_sync_mode(omniauth, authentication)
    # heh its in milliseconds!
    last_edit = omniauth.extra.raw_info.lastModifiedTimestamp / 1000
    last_sync = authentication.last_synced
    
    if (!last_sync || last_edit > last_sync )
      Logger.new(STDOUT).info "Going to update #{authentication.uid} because #{last_edit} > #{last_sync}"
      :all
    # elsif session[:sync_mode]
    #   session[:sync_mode].to_sym
    else
      nil
    end

  end
    
  alias_method :linkedin, :create
end
