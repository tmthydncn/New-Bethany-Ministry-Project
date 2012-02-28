class ShowerVisitsController < ApplicationController
  before_filter :signed_in_user
  # GET /shower_visits
  # GET /shower_visits.json
  def index
    @shower_visits = ShowerVisit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shower_visits }
    end
  end

  # GET /shower_visits/1
  # GET /shower_visits/1.json
  def show
    @shower_visit = ShowerVisit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shower_visit }
    end
  end

  # GET /shower_visits/new
  # GET /shower_visits/new.json
  def new
    @shower_visit = ShowerVisit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shower_visit }
    end
  end

  # GET /shower_visits/1/edit
  def edit
    @shower_visit = ShowerVisit.find(params[:id])
  end

  # POST /shower_visits
  # POST /shower_visits.json
  def create
    @shower_visit = ShowerVisit.new(params[:shower_visit])

    respond_to do |format|
      if @shower_visit.save
        format.html { redirect_to @shower_visit, notice: 'Shower visit was successfully created.' }
        format.json { render json: @shower_visit, status: :created, location: @shower_visit }
      else
        format.html { render action: "new" }
        format.json { render json: @shower_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shower_visits/1
  # PUT /shower_visits/1.json
  def update
    @shower_visit = ShowerVisit.find(params[:id])

    respond_to do |format|
      if @shower_visit.update_attributes(params[:shower_visit])
        format.html { redirect_to @shower_visit, notice: 'Shower visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shower_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shower_visits/1
  # DELETE /shower_visits/1.json
  def destroy
    @shower_visit = ShowerVisit.find(params[:id])
    @shower_visit.destroy

    respond_to do |format|
      format.html { redirect_to shower_visits_url }
      format.json { head :no_content }
    end
  end
end
