class TicketCategoriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /ticketcategories
  # GET /ticketcategories.json
  def index
    if logged_in?
      @owner = current_user
      @ticket_categories_all = current_user.ticket_categories.paginate(page: params[:page]).order('name ASC')

      respond_to do |format|
        format.html { render @ticket_categories }
        format.json { render json: @ticket_categories }
      end
  
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /ticketcategories/1
  # GET /ticketcategories/1.json
  def show
    if logged_in?
      @ticket_category = current_user.ticket_categories.find(params[:id])
    
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # GET /ticketcategories/new
  def new
    if logged_in?
      @owner = current_user
      @ticket_category = TicketCategory.new
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end
  
  # POST /ticketcategories
  # POST /ticketcategories.json
  def create
    @ticket_category = current_user.ticket_categories.create(ticket_category_params)
    @owner = current_user
    if @ticket_category.persisted?
      flash[:green] = "Ticket category created!"
      redirect_to ticket_categories_path
    else
      render root_path
    end
  end

  # GET /ticketcategories/1/edit
  def edit
    if logged_in?
      @owner = current_user
      @ticket_category = current_user.ticket_categories.find(params[:id])
    else
      flash[:red] = "Please sign in."
      redirect_to login_url
    end
  end

  # PATCH/PUT /ticketcategories/1
  # PATCH/PUT /ticketcategories/1.json
  def update
    @ticket_category = current_user.ticket_categories.find(params[:id])
    if @ticket_category.update_attributes(ticket_category_params)
      flash[:green] = "Ticket category was successfully updated."
      redirect_to @ticket_category
    else
      render :edit
    end
  end

  def delete
    @ticket_category = current_user.ticket_categories.find(params[:id])
  end
  
  def destroy
    @ticket_category = current_user.ticket_categories.find(params[:id]).destroy
    flash[:green] = "Ticket Category destroyed successfully."
    redirect_to ticket_categories_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_category_params
      params.require(:ticket_category).permit(:name, :owner_id)
    end
    
    def correct_user
      @asset = current_user.assets.find_by(id: params[:id])
      redirect_to root_url if @asset.nil?
    end
end
