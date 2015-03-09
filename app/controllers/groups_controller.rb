class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /groups
  # GET /groups.json
  def index
    if logged_in?
      @groups_all = current_user.groups.paginate(page: params[:page]).order('name ASC')
    
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
    
      respond_to do |format|
        format.html { render @groups }
        format.json { render json: @groups }
      end
    
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
    
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if logged_in?
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('name ASC')
      @group_locations = AssetLocation.where("owner_id = ?", current_user).order('name ASC')
      @group = current_user.groups.find(params[:id])
      
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /groups/new
  def new
    if logged_in?
      @owner = current_user
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @group = Group.new
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
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
    if logged_in?
      @groups_all = current_user.groups.order('serial ASC')
      
      @users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @group = Group.where("owner_id = ?", current_user).find(params[:id])
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
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
    
    def correct_user
      @group = current_user.groups.find_by(id: params[:id])
      redirect_to root_url if @group.nil?
    end
    
end
  