class BasketVisitsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: [:create, :destroy]
  before_filter :title

  # GET /basket_visits
  # GET /basket_visits.json
  def index
    @basket_visits = BasketVisit.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @basket_visits }
    end
  end

  # GET /basket_visits/1
  # GET /basket_visits/1.json
  def show
    @basket_visit = BasketVisit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @basket_visit }
    end
  end

  # GET /basket_visits/new
  # GET /basket_visits/new.json
  def new
    
    @next_order = BasketVisit.find(:first, :order => "updated_at desc")
    if @next_order.nil? 
      @next_order = nil
    else
      @prev_order = @next_order.order_number
      @next_order = @prev_order + 1
    end
    @basket_visit = BasketVisit.new
    @person = current_person
    if @person.nil?
      flash[:error] = "Unable to create new with no person"
      redirect_to search_people_url
      return
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @basket_visit }
    end
  end

  # GET /basket_visits/1/edit
  def edit
    @basket_visit = BasketVisit.find(params[:id])
  end

  # POST /basket_visits
  # POST /basket_visits.json
  def create
    
    @basket_visit = BasketVisit.new(params[:basket_visit])
    @basket_visit.user_id = current_user.id
    respond_to do |format|
      if @basket_visit.save
        format.html { redirect_to pending_basket_visits_path, success: 'Basket visit was successfully created.' }
        format.json { render json: @basket_visit, status: :created, location: @basket_visit }
      else
        format.html { render action: "new" }
        format.json { render json: @basket_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /basket_visits/1
  # PUT /basket_visits/1.json
  def update
    @basket_visit = BasketVisit.find(params[:id])

    respond_to do |format|
      if @basket_visit.update_attributes(params[:basket_visit])
        @basket_visit.update_attribute(:user_id,current_user.id)
        format.html { redirect_to pending_basket_visits_path, notice: 'Basket visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @basket_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /basket_visits/1
  # DELETE /basket_visits/1.json
  def destroy
    @basket_visit = BasketVisit.find(params[:id])
    @basket_visit.destroy

    respond_to do |format|
      format.html { redirect_to basket_visits_url }
      format.json { head :no_content }
    end
  end
  
  def search
    @person = current_person
    if @person.nil?
      flash[:error] = "Unable to search with no person"
      redirect_to :action=>"index", :controller=>"basket_visits"
      return
    end
    
    @basket_visits = BasketVisit.paginate(:page => params[:page], :per_page => 10, :conditions => ["person_id = ?", current_person.id], :order => 'updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @basket_visits }
    end
  end   
  
  def pending
    @basket_visits = BasketVisit.find_all_by_status(BasketVisit::STATUS_TYPES[0])
    @basket_visits_old = BasketVisit.find(:all, :limit => 10, :conditions => ["status != ?",BasketVisit::STATUS_TYPES[0]], order: 'basket_visits.created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @basket_visits }
    end
  end
  
  def processed
    basket_visit = BasketVisit.find(params[:id])
    
    respond_to do |format|
      if basket_visit.update_attribute :status, BasketVisit::STATUS_TYPES[1]
        flash[:success] = "Basket Visit marked as completed."
        format.html { redirect_to pending_basket_visits_path }
      else
        flash[:error] = "Unable to mark Basket Visit as completed."
        format.html { redirect_to pending_basket_visits_path }
      end
      format.json { head :no_content }
    end
  end
  
  
  private
    
    def title
      @title = "Basket Visits"
    end

  
end