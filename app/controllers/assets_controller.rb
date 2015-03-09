class AssetsController < ApplicationController
  
  force_ssl
  
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /assets
  # GET /assets.json
  def index
    if logged_in?
      @assets_all = current_user.assets
      .search(params[:search])
      .paginate(page: params[:page]).order('serial ASC')
    
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    
      respond_to do |format|
        format.html { render @assets }
        format.json { render json: @assets }
        format.js
      end
    
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
    
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    if logged_in?
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('name ASC')
      @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
      @asset = current_user.assets.find(params[:id])
      
      @user_fullname  = "#{@asset.user.lastname}, #{@asset.user.firstname}"
      @owner_fullname = "#{@asset.owner.lastname}, #{@asset.owner.firstname}"
      
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /assets/new
  def new
    if logged_in?
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
      @asset = Asset.new
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /assets/1/edit
  def edit
    if logged_in?
      @assets_all = current_user.assets.order('serial ASC')
      
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
      @asset = Asset.where("owner_id = ?", current_user).find(params[:id])
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @asset = current_user.assets.create(asset_params)
    @owner = current_user
    if @asset.persisted?
      flash[:green] = "Asset created!"
      redirect_to assets_path
    else
      render root_path
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @asset = current_user.assets.find(params[:id])
    if @asset.update_attributes(asset_params)
      flash[:green] = "Asset was successfully updated."
      redirect_to @asset
    else
      render :edit
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def asset_params
      params.require(:asset).permit(
        :serial, 
        :brand, 
        :kind, 
        :date_acquired, 
        :user_id, 
        :comment, 
        :ware, 
        :asset_location_id, 
        :recycled, 
        :owner_id
      )
    end
    
    def correct_user
      @asset = current_user.assets.find_by(id: params[:id])
      redirect_to root_url if @asset.nil?
    end
    
end
