class UsersController < ApplicationController

  # force_ssl

  before_action :authenticate_user!

  # GET /users
  # GET /users.json

  def index

    @users_all = current_user.users.search(params[:search])
      .paginate(page: params[:page])
      .order('lastname ASC')
    if current_user.business
      @businesses = current_user.business.name
    end

    respond_to do |format|
      format.html { render @users }
      format.json { render json: @tickets_unsolved }
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @users_all = current_user.users.order('lastname ASC')
    if current_user.business
      @business = current_user.business.name
    end
    @user = current_user
    @user_tickets = Ticket.where(:user => @user).order('date_opened DESC')
      .paginate(page: params[:page])
    @user_assets = Asset.where(:user => @user).order('serial ASC')
      .paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @owner = current_user
    @businesses = current_user.businesses
    @groups = current_user.groups
    @user = User.new
  end

  # POST /users
  def create
    if current_user
      @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
      @groups = current_user.groups
      @user = User.create(user_params)
      if @user.persisted?
        flash[:green] = "User created!"
        redirect_to users_path
      else
        redirect_to root_path
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
    @users_all = current_user.users
    @owner = current_user
    @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
    @groups = current_user.groups
    @user = current_user
  end

  # PATCH/PUT /users/1
  def update
    @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
    @groups = current_user.groups
    @user = current_user
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
      redirect_to(root_url) unless current_user.id == @user.id
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

end
