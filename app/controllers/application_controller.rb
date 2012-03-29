class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
 
  private

    def current_person 
      #session[:person_id] = params[:person_id]
      Person.find(params[:person_id])
    rescue ActiveRecord::RecordNotFound
      nil
      #session[:person_id] = nil
    end
    
    def admin_user
      if !current_user.admin?
        flash[:error] = "You do no have administrator privilages"
        redirect_to(root_path)
      end
    end
end
