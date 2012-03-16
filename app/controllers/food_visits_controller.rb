class FoodVisitsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: [:create, :destroy]
  before_filter :title

  # GET /food_visits
  # GET /food_visits.json
  def index
    @food_visits = FoodVisit.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_visits }
    end
  end

  # GET /food_visits/1
  # GET /food_visits/1.json
  def show
    @food_visit = FoodVisit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food_visit }
    end
  end

  # GET /food_visits/new
  # GET /food_visits/new.json
  def new
    
    @next_order = FoodVisit.find(:first, :order => "updated_at desc")
    if @next_order.nil? 
      @next_order = nil
    else
      @prev_order = @next_order.order_number
      @next_order = @prev_order + 1
    end
    @food_visit = FoodVisit.new
    @person = current_person
    if @person.nil?
      flash[:error] = "Unable to create new with no person"
      redirect_to search_people_url
      return
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food_visit }
    end
  end

  # GET /food_visits/1/edit
  def edit
    @food_visit = FoodVisit.find(params[:id])
  end

  # POST /food_visits
  # POST /food_visits.json
  def create
    
    @food_visit = FoodVisit.new(params[:food_visit])
    @food_visit.user_id = current_user.id
    respond_to do |format|
      if @food_visit.save
        format.html { redirect_to pending_food_visits_path, success: 'Food visit was successfully created.' }
        format.json { render json: @food_visit, status: :created, location: @food_visit }
      else
        format.html { render action: "new" }
        format.json { render json: @food_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /food_visits/1
  # PUT /food_visits/1.json
  def update
    @food_visit = FoodVisit.find(params[:id])

    respond_to do |format|
      if @food_visit.update_attributes(params[:food_visit])
        @food_visit.update_attribute(:user_id,current_user.id)
        format.html { redirect_to pending_food_visits_path, notice: 'Food visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_visits/1
  # DELETE /food_visits/1.json
  def destroy
    @food_visit = FoodVisit.find(params[:id])
    @food_visit.destroy

    respond_to do |format|
      format.html { redirect_to food_visits_url }
      format.json { head :no_content }
    end
  end
  
  def search
    @person = current_person
    if @person.nil?
      flash[:error] = "Unable to search with no person"
      redirect_to :action=>"index", :controller=>"food_visits"
      return
    end
    
    @food_visits = FoodVisit.paginate(:page => params[:page], :per_page => 10, :conditions => ["person_id = ?", current_person.id], :order => 'updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_visits }
    end
  end   
  
  def pending
    @food_visits = FoodVisit.find_all_by_status(FoodVisit::STATUS_TYPES[0])
    @food_visits_old = FoodVisit.find(:all, :limit => 10, :conditions => ["status != ?",FoodVisit::STATUS_TYPES[0]], order: 'food_visits.created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_visits }
    end
  end
  
  def processed
    food_visit = FoodVisit.find(params[:id])
    
    respond_to do |format|
      if food_visit.update_attribute :status, FoodVisit::STATUS_TYPES[1]
        flash[:success] = "Food Visit marked as completed."
        format.html { redirect_to pending_food_visits_path }
      else
        flash[:error] = "Unable to mark Food Visit as completed."
        format.html { redirect_to pending_food_visits_path }
      end
      format.json { head :no_content }
    end
  end
  
  
  private
    
    def title
      @title = "Food Visits"
    end

  
end