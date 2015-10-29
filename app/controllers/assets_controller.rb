class AssetsController < ApplicationController

  # force_ssl

  before_action :authenticate_user!

  # GET /assets
  # GET /assets.json
  def index
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
      format.csv { send_data current_user.assets.to_csv }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @owner = current_user
    @users = User.where("owner_id = ?", current_user).order('name ASC')
    @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @asset = current_user.assets.find(params[:id])

    @user_fullname  = "#{@asset.user.lastname}, #{@asset.user.firstname}"
    @owner_fullname = "#{@asset.owner.lastname}, #{@asset.owner.firstname}"
  end

  # GET /assets/new
  def new
    @owner = current_user
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @asset = current_user.assets.new
  end

  # GET /assets/1/edit
  def edit
    @assets_all = current_user.assets.order('serial ASC')
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @asset_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @asset = current_user.assets.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset_locations = current_user.asset_locations.order('name ASC')
    @owner = current_user
    @asset = current_user.assets.create(asset_params)
    if @asset.save
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
    @asset = current_user.assets.find(params[:id])
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

end
