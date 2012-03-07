class ReportController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :admin_user
  
  before_filter :title
  
  def food_visit
    if params[:start].nil?
      @food_visit = nil
    else
      atStart = DateTime.civil(params[:start]["(1i)"].to_i,params[:start]["(2i)"].to_i,params[:start]["(3i)"].to_i, Rational(-5, 24))
      atEnd = DateTime.civil(params[:end]["(1i)"].to_i,params[:end]["(2i)"].to_i,params[:end]["(3i)"].to_i, Rational(-5, 24))

      @food_visits = FoodVisit.all( :select => "created_at, SUM(number_of_adults) number_of_adults, SUM(number_of_children) number_of_children, SUM(number_of_elderly) number_of_elderly", :conditions => ["created_at between ? and ? and status = ?", atStart.to_time, atEnd.to_time, FoodVisit::STATUS_TYPES[1]], :group => ["DATE(created_at)"])
    end
    params[:start] = nil
    params[:end] = nil 
    respond_to do |format|
      format.html 
      format.json { render json: @food_visits }
    end
  end
  
  
  private 
    
    def title
      @title = "Report"
    end
end
