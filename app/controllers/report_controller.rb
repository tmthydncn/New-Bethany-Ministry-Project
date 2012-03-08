class ReportController < ApplicationController
    include ActionView::Helpers::DateHelper
  
  before_filter :signed_in_user
  before_filter :admin_user
  
  before_filter :title
  
  def food_visit
    if params[:start_date].nil? or params[:start_date].empty? or params[:end_date].empty?
      @query_humanized = "Unable to search. Please check the dates"
      @food_visit = nil
    else
      begin
        atStart = Time.strptime(params[:start_date], '%m/%d/%Y').getutc
        atEnd = Time.strptime(params[:end_date], '%m/%d/%Y').getutc
        if atEnd <= atStart
          @query_humanized = "Unable to search. End date must be at least one day after the start date"
        else
          @food_visits = FoodVisit.all( :select => "created_at, SUM(number_of_adults) number_of_adults, SUM(number_of_children) number_of_children, SUM(number_of_elderly) number_of_elderly", :conditions => ["created_at between ? and ? and status = ?", atStart.to_time, atEnd.to_time, FoodVisit::STATUS_TYPES[1]], :group => ["DATE(created_at)"])
          @food_visits_total = FoodVisit.find(:first, :select => "SUM(number_of_adults) number_of_adults, SUM(number_of_children) number_of_children, SUM(number_of_elderly) number_of_elderly", :conditions => ["created_at between ? and ? and status = ?", atStart.to_time, atEnd.to_time, FoodVisit::STATUS_TYPES[1]])
          @days = distance_of_time_in_words(atStart,atEnd)
          @query_humanized = "Generating report of #{@days} from #{atStart.to_date} to #{atEnd.to_date}"
        end
      rescue
        @query_humanized = "Unable to search. Please check the dates"
      end

    end
    
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
