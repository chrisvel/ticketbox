class TicketCategoriesController < ApplicationController
  before_action :authenticate_user!

  # GET /ticketcategories
  # GET /ticketcategories.json
  def index
    @owner = current_user
    @ticket_categories_all = current_user.ticket_categories.paginate(page: params[:page]).order('name ASC')

    respond_to do |format|
      format.html { render @ticket_categories }
      format.json { render json: @ticket_categories }
    end
  end

  # GET /ticketcategories/1
  # GET /ticketcategories/1.json
  def show
    @ticket_category = current_user.ticket_categories.find(params[:id])
  end

  # GET /ticketcategories/new
  def new
    @owner = current_user
    @ticket_category = TicketCategory.new
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
    @owner = current_user
    @ticket_category = current_user.ticket_categories.find(params[:id])
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

end
