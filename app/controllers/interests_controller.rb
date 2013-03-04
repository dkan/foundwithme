class InterestsController < ApplicationController
  def search
    @interests = Interest.where(['name like ?', "#{params[:interest_name].downcase}%"])

    respond_to do |format|
      format.json { render json: @interests, status: :ok }
    end
  end
end
