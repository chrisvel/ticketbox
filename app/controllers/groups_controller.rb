class GroupsController < ApplicationController
  before_action :authenticate_user!

  # GET /groups
  # GET /groups.json
  def index
    @groups_all = current_user.groups.paginate(page: params[:page]).order('name ASC')

    @owner = current_user
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')

    respond_to do |format|
      format.html { render @groups }
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @owner = current_user
    @users = User.where("owner_id = ?", current_user).order('name ASC')
    @group_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
    @group = current_user.groups.find(params[:id])
  end

  # GET /groups/new
  def new
    @owner = current_user
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @group = Group.new
  end
  
  # POST /groups
  # POST /groups.json
  def create
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @group = current_user.groups.create(group_params)
    @owner = current_user
    if @group.persisted?
      flash[:green] = "Group created!"
      redirect_to groups_path
    else
      render root_path
    end
  end

  # GET /groups/1/edit
  def edit
    @groups_all = current_user.groups.order('serial ASC')

    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @group = Group.where("owner_id = ?", current_user).find(params[:id])
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    @group = current_user.groups.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:green] = "Asset was successfully updated."
      redirect_to @group
    else
      render :edit
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def group_params
      params.require(:group).permit(
        :name,
        :user_id, 
        :owner_id
      )
    end
    
end
  