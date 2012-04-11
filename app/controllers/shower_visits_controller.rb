class ShowerVisitsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: [:create, :destroy]
  before_filter :title

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
      @next_order = ShowerVisit.find(:first, :order => "updated_at desc")
      if @next_order.nil?  or @next_order.order_number.nil?
        @next_order = nil
      else
        @prev_order = @next_order.order_number
        @next_order = @prev_order + 1
      end
      @shower_visit = ShowerVisit.new
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


  # GET /shower_visits/1/edit
  def edit
    @shower_visit = ShowerVisit.find(params[:id])
  end

  # POST /shower_visits
  # POST /shower_visits.json
  def create
    @shower_visit = ShowerVisit.new(params[:shower_visit])
    @shower_visit.user_id = current_user.id
    respond_to do |format|
      if @shower_visit.save
        format.html { redirect_to pending_shower_visits_path, notice: 'Shower visit was successfully created.' }
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
        @shower_visit.update_attribute(:user_id,current_user.id)
        format.html { redirect_to pending_shower_visits_path, notice: 'Shower visit was successfully updated.' }
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
      format.html { redirect_to pending_shower_visits_path }
      format.json { head :no_content }
    end
  end



    def search
      @person = current_person
      if @person.nil?
        flash[:error] = "Unable to search with no person"
        redirect_to :action=>"index", :controller=>"shower_visits"
        return
      end

      @shower_visits = ShowerVisit.paginate(:page => params[:page], :per_page => 10, :conditions => ["person_id = ?", current_person.id], :order => 'updated_at DESC')
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @food_visits }
      end
    end   

    def pending
      @shower_visits = ShowerVisit.find_all_by_status(ShowerVisit::STATUS_TYPES[0])
      @shower_visits_old = ShowerVisit.find(:all, :limit => 10, :conditions => ["status != ?",ShowerVisit::STATUS_TYPES[0]], order: 'shower_visits.created_at DESC')
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @food_visits }
      end
    end

    def processed
      shower_visit = ShowerVisit.find(params[:id])

      respond_to do |format|
        if shower_visit.update_attribute :status, ShowerVisit::STATUS_TYPES[1]
          flash[:success] = "Shower Visit marked as completed."
          format.html { redirect_to pending_shower_visits_path }
        else
          flash[:error] = "Unable to mark Shower Visit as completed."
          format.html { redirect_to pending_shower_visits_path }
        end
        format.json { head :no_content }
      end
    end


    private

      def title
        @title = "Shower Visits"
      end


  end




