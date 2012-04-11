class OtherVisitsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: [:create, :destroy]
  before_filter :title

  # GET /other_visits
  # GET /other_visits.json
  def index
    @other_visits = OtherVisit.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @other_visits }
    end
  end

  # GET /other_visits/1
  # GET /other_visits/1.json
  def show
    @other_visit = OtherVisit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @other_visit }
    end
  end

  # GET /other_visits/new
  # GET /other_visits/new.json
  def new
    @next_order = OtherVisit.find(:first, :order => "updated_at desc")
     if @next_order.nil? 
       @next_order = nil
     else
       @prev_order = @next_order.order_number
       @next_order = @prev_order + 1
     end
    @other_visit = OtherVisit.new
    @person = current_person
    if @person.nil?
      flash[:error] = "Unable to create new with no person"
      redirect_to search_people_url
      return
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @other_visit }
    end
  end

  # GET /other_visits/1/edit
  def edit
    @other_visit = OtherVisit.find(params[:id])
  end

  # POST /other_visits
  # POST /other_visits.json
  def create
    @other_visit = OtherVisit.new(params[:other_visit])
    @other_visit.user_id = current_user.id
    respond_to do |format|
      if @other_visit.save
        format.html { redirect_to pending_other_visits_path, success: 'Other visit was successfully created.' }
        format.json { render json: @other_visit, status: :created, location: @other_visit }
      else
        format.html { render action: "new" }
        format.json { render json: @other_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /other_visits/1
  # PUT /other_visits/1.json
  def update
    @other_visit = OtherVisit.find(params[:id])

    respond_to do |format|
      if @other_visit.update_attributes(params[:other_visit])
        @other_visit.update_attribute(:user_id,current_user.id)
        format.html { redirect_to pending_other_visits_path, notice: 'Other visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @other_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /other_visits/1
  # DELETE /other_visits/1.json
  def destroy
    @other_visit = OtherVisit.find(params[:id])
    @other_visit.destroy

    respond_to do |format|
      format.html { redirect_to other_visits_url }
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

    @other_visits = OtherVisit.paginate(:page => params[:page], :per_page => 10, :conditions => ["person_id = ?", current_person.id], :order => 'updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @other_visits }
    end
  end   

  def pending
    @other_visits = OtherVisit.find_all_by_status(OtherVisit::STATUS_TYPES[0])
    @other_visits_old = OtherVisit.find(:all, :limit => 10, :conditions => ["status != ?",OtherVisit::STATUS_TYPES[0]], order: 'other_visits.created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @other_visits }
    end
  end
  
  
  def processed
    other_visit = OtherVisit.find(params[:id])

    respond_to do |format|
      if other_visit.update_attribute :status, OtherVisit::STATUS_TYPES[1]
        flash[:success] = "Other Visit marked as completed."
        format.html { redirect_to pending_other_visits_path }
      else
        flash[:error] = "Unable to mark Other Visit as completed."
        format.html { redirect_to pending_other_visits_path }
      end
      format.json { head :no_content }
    end
  end
  
  
  

  private

    def title
      @title = "Other Visits"
    end


end