class PeopleController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: [:create, :destroy]
  
  before_filter :title

  
  # GET /people
  # GET /people.json
  def index
    # session[:person_id] = nil
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    begin
      params[:person][:date_of_birth] = Date.strptime(params[:person][:date_of_birth], '%Y-%m-%d')
    rescue
      begin
        params[:person][:date_of_birth] = Date.strptime(params[:person][:date_of_birth], '%B %d, %Y')
      rescue
        params[:person][:date_of_birth] = nil
      end
    end
    @person = Person.new(params[:person])
    @person.user_id = current_user.id

    respond_to do |format|
      if @person.save
        format.html { redirect_to search_people_path, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])
    params[:person][:date_of_birth] = Date.strptime(params[:person][:date_of_birth], '%Y-%m-%d')
    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to search_people_path, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def search
    query = ['']
    if not params[:query].nil?
      query = params[:query].delete(",").split(" ")
    end
    queries = []
    vars = []
    len = query.length
    query.each_with_index do |q, index|
      q = q.downcase
      queries << "lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR CAST(ssn AS TEXT) LIKE ? "
      vars << (q << '%') << q << ('%' + q.gsub(/[-]/, '') + '%')
    end
  
      @people = Person.paginate :page => params[:page], :per_page => 5, :conditions =>[queries.join(' OR '), vars].flatten, :order => "lower(first_name), lower(last_name), ssn"

    respond_to do |format|
      format.html
      format.json
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to search_people_path }
      format.json { head :no_content }
    end
  end
  
  private 
    
    def title
      @title = "People"
    end
end
