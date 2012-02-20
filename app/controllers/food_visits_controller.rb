class FoodVisitsController < ApplicationController
  # GET /food_visits
  # GET /food_visits.json
  def index
    session[:person_id] = params[:person_id]
    @person = current_person
    @food_visits = FoodVisit.joins(:person).where('people.id = ?', params[:person_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_visits }
    end
  end

  # GET /food_visits/1
  # GET /food_visits/1.json
  def show
    session[:person_id] = params[:person_id]
    @food_visit = FoodVisit.find(params[:id])
    @person = current_person
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food_visit }
    end
  end

  # GET /food_visits/new
  # GET /food_visits/new.json
  def new
    @food_visit = FoodVisit.new
    

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
    session[:person_id] = params[:person_id]
    @person = current_person
    @food_visit = FoodVisit.new(params[:food_visit])
    @food_visit.person_id = current_person.id
    
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
  
  
end