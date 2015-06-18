class AssetLocationsController < ApplicationController
  before_action :authenticate_user!

  # GET /asset_locations
  # GET /asset_locations.json
  def index
    @owner = current_user
    @asset_locations_all = current_user.asset_locations.paginate(page: params[:page]).order('name ASC')

    respond_to do |format|
      format.html { render @asset_locations }
      format.json { render json: @asset_locations }
    end
  end

  # GET /asset_locations/1
  # GET /asset_locations/1.json
  def show
    @asset_location = current_user.asset_locations.find(params[:id])
  end

  # GET /ticketcategories/new
  def new
    @owner = current_user
    @asset_location = AssetLocation.new
  end
  
  # POST /ticketcategories
  # POST /ticketcategories.json
  def create
    @asset_location = current_user.asset_locations.create(asset_location_params)
    @owner = current_user
    if @asset_location.persisted?
      flash[:green] = "Ticket category created!"
      redirect_to asset_locations_path
    else
      render root_path
    end
  end

  # GET /ticketcategories/1/edit
  def edit
    @owner = current_user
    @asset_location = current_user.asset_locations.find(params[:id])
  end

  # PATCH/PUT /ticketcategories/1
  # PATCH/PUT /ticketcategories/1.json
  def update
    @asset_location = current_user.asset_locations.find(params[:id])
    if @asset_location.update_attributes(asset_location_params)
      flash[:green] = "Asset location was successfully updated."
      redirect_to @asset_location
    else
      render :edit
    end
  end

  # DELETE /asset_locations/1
  # DELETE /asset_locations/1.json
  def destroy
    @asset_location.destroy
    respond_to do |format|
      format.html { redirect_to asset_locations_url, notice: 'Assets assetlocation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_location_params
      params.require(:asset_location).permit(:name, :owner_id)
    end

end
