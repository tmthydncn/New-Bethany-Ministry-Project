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
          @food_visits = FoodVisit.all( :select => "DATE(created_at) as created_at, SUM(number_of_adults) as number_of_adults, SUM(number_of_children) as number_of_children, SUM(number_of_elderly) as number_of_elderly", :conditions => ["created_at between ? and ? and status = ?", atStart.to_time, atEnd.to_time, FoodVisit::STATUS_TYPES[1]], :group => ["DATE(created_at)"])
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
  
  def shower_visit
    if params[:start_date].nil? or params[:start_date].empty? or params[:end_date].empty?
      @query_humanized = "Unable to search. Please check the dates"
      @shower_visit = nil
    else
      begin
        atStart = Time.strptime(params[:start_date], '%m/%d/%Y').getutc
        atEnd = Time.strptime(params[:end_date], '%m/%d/%Y').getutc
        if atEnd <= atStart
          @query_humanized = "Unable to search. End date must be at least one day after the start date"
        else
          @shower_visits = ShowerVisit.all( :select => "DATE(created_at) as created_at, COUNT(CASE WHEN soap THEN 1 ELSE null END) as soap_count, COUNT(CASE WHEN towel THEN 1 ELSE null END) as towel_count, Count(CASE WHEN shampoo THEN 1 ELSE null END) as shampoo_count", :conditions => ["created_at between ? and ? and status = ?", atStart.to_time, atEnd.to_time, ShowerVisit::STATUS_TYPES[1]], :group => ["DATE(created_at)"])
          @days = distance_of_time_in_words(atStart,atEnd)
          @query_humanized = "Generating report of #{@days} from #{atStart.to_date} to #{atEnd.to_date}"
        end
      rescue
        @query_humanized = "Unable to search. Please check the dates"
      end

    end
    
    respond_to do |format|
      format.html
      format.json { render json: @shower_visits }
    end
  end  
  private 
    
    def title
      @title = "Report"
    end
end
