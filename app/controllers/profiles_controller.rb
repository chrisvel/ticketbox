class ProfilesController < ApplicationController

  before_action :authenticate_user!

  # GET /profiles
  # GET /profiles.json

  def index

    # TODO current_user.users.search.....
    @profiles_all = current_user.profiles.search(params[:search])
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

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profiles_all = current_user.profiles.order('lastname ASC')
    if current_user.business
      @business = current_user.business.name
    end
    @profile = current_user.profiles.find(params[:id])
    @profile_tickets = Ticket.where(:user => @user).order('date_opened DESC')
      .paginate(page: params[:page])
    @profile_assets = Asset.where(:user => @user).order('serial ASC')
      .paginate(page: params[:page])
  end

  # GET /profiles/new
  def new
    @businesses = current_user.businesses
    @groups = current_user.groups
    @profile = User.new
    @profile.profile_id = current_user.id
  end

  # POST /users
  def create
    if current_user
      @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
      @groups = current_user.groups
      @profile = User.create(user_params)
      @profile.profile_id = current_user.id
      if @profile.persisted?
        flash[:green] = "User created!"
        redirect_to users_path
      else
        redirect_to root_path
      end
    else
      @profile = User.new(user_params)
      if @profile.save
        @profile.send_activation_email
        flash[:blue] = "Please check your email to activate your account."
        redirect_to root_path
      else
        render :signup
      end
    end
  end

  # GET /profiles/1/edit
  def edit
    @users_all = current_user.users
    @owner = current_user
    @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
    @groups = current_user.groups
    @profile = current_user.profiles.find(params[:id])
  end

  # PATCH/PUT /profiles/1
  def update
    @businesses = Business.where("owner_id = ?", current_user).order('name ASC')
    @groups = current_user.groups
    @profile = current_user.profiles.find(params[:id])
    if @profile.update_attributes(user_params)
      flash[:green] = "User was successfully updated."
      redirect_to @profile
    else
      render :edit
    end
  end

  # DELETE /profiles/1
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
