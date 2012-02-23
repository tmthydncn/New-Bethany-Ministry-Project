class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  private

    def current_person 
      #session[:person_id] = params[:person_id]
      Person.find(params[:person_id])
    rescue ActiveRecord::RecordNotFound
      nil
      #session[:person_id] = nil
    end
end
