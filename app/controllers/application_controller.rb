class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  private

    def current_person 
      flash[:notice] = session[:person_id]
      Person.find(session[:person_id])
    rescue ActiveRecord::RecordNotFound
      person = nil
      session[:person_id] = nil
    end
end
