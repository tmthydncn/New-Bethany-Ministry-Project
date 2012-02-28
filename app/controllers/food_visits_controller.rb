class FoodVisitsController < ApplicationController
  before_filter :signed_in_user
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
    
    respond_to do |format|
      if @food_visit.save
        format.html { redirect_to @food_visit, notice: 'Food visit was successfully created.' }
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
        format.html { redirect_to @food_visit, notice: 'Food visit was successfully updated.' }
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
    @food_visits = FoodVisit.find_all_by_person_id(current_person.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_visits }
    end
  end   
  
  
end
