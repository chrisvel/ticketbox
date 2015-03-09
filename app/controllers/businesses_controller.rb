class BusinessesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /businesses
  # GET /businesses.json
  def index
    if logged_in?
      @businesses_all = current_user.businesses.paginate(page: params[:page]).order('name ASC')

      respond_to do |format|
        format.html { render @businesses }
        format.json { render json: @businesses }
      end
    
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
    
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    if logged_in?
      @business = current_user.businesses.find(params[:id])
      
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /businesses/new
  def new
    if logged_in?
      @owner = current_user
      @business = Business.new
      @user = User.new
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /businesses/1/edit
  def edit
    if logged_in?
      @owner = current_user
      @business = current_user.businesses.find(params[:id])
      @user = User.new
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = current_user.businesses.create(business_params)
    @owner = current_user
    @user = User.new
    if @business.persisted?
      flash[:green] = "Business created!"
      redirect_to businesses_path
    else
      render root_path
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    @business = current_user.businesses.find(params[:id])
    @user = User.new
    if @business.update_attributes(business_params)
      flash[:green] = "Business was successfully updated."
      redirect_to @business
    else
      render :edit
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Assets business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :owner_id)
    end
    
    def correct_user
      @asset = current_user.assets.find_by(id: params[:id])
      redirect_to root_url if @asset.nil?
    end
end
