class UsersController < ApplicationController
  
  force_ssl
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :owner_delete,   only: :destroy

  # GET /users
  # GET /users.json

  def index
    if logged_in?
      @users_all = current_user.users.search(params[:search])
        .paginate(page: params[:page])
        .order('lastname ASC')
      if current_user.owner.business
        @businesses = current_user.owner.business.name
      end
      
      respond_to do |format|
        format.html { render @users }
        format.json { render json: @tickets_unsolved }
        format.js 
      end
      
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if logged_in?
      @users_all = current_user.users.order('lastname ASC')
      if current_user.owner.business
        @business = current_user.owner.business.name
      end
      @user = current_user.users.find(params[:id])
      @user_tickets = Ticket.where(:user => @user).order('date_opened DESC')
        .paginate(page: params[:page])
      @user_assets = Asset.where(:user => @user).order('serial ASC')
        .paginate(page: params[:page])
        
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /users/new
  def new
    @owner = current_user
    @businesses = current_user.owner.businesses
    @groups = current_user.owner.groups
    @user = User.new
  end
  
  # POST /users
  def create
    if current_user
      @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
      @groups = current_user.owner.groups
      @user = current_user.users.create(user_params)
      if @user.persisted?
        flash[:green] = "User created!"
        redirect_to users_path
      else
        render root_path
      end
    else
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:blue] = "Please check your email to activate your account."
        redirect_to root_path
      else
        render :signup
      end
    end
  end

  # GET /users/1/edit
  def edit
    if logged_in?
      @users_all = current_user.users.paginate(page: params[:page]).order('lastname ASC')
      @owner = current_user
      @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
      @groups = current_user.owner.groups
      @user = current_user.users.find(params[:id])
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end
  
  # PATCH/PUT /users/1
  def update
    @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
    @groups = current_user.owner.groups
    @user = current_user.users.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:green] = "User was successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    flash[:green] = "User deleted."
    redirect_to users_url
  end
  
  # /signup
  def signup
    @user = User.new
  end

  private
  
    def owner_delete
      redirect_to(root_url) unless current_user.id == @user.owner.id
    end 

    def user_params
      params.require(:user).permit(
        :firstname,
        :lastname,
        :username, 
        :email, 
        :password, 
        :password_confirmation,
        :business_id,
        :leaver,
        :owner_id,
        :time_zone,
        :position,
        :department,
        :landline_phone,
        :mobile_phone,
        :avatar,
        :group_id
        )
    end

    def correct_user
      @user = current_user.users.find_by(id: params[:id])
      redirect_to root_url if @user.nil?
    end
    
end
