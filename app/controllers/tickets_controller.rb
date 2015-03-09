class TicketsController < ApplicationController
  
  force_ssl
  
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :get_all_unsolved, 
                :get_all_solved,
                :get_all_tickets,
                :get_all_aborted,
                only: [:index, :show, :edit]
  before_action :get_all_ticket_categories, 
                :get_users,
                only: [:index, :show, :edit, :new, :create, :update]

  def index
    @ticket = Ticket.new
    respond_to do |format|
      format.html { render @tickets }
      format.json { render json: @tickets_unsolved }
    end
  end

  def show
      @ticket = current_user.tickets.find(params[:id])
      @user_fullname  = "#{@ticket.user.lastname}, #{@ticket.user.firstname}"
      @owner_fullname = "#{@ticket.owner.lastname}, #{@ticket.owner.firstname}"
  end

  def edit
    #@ticket = Ticket.where("owner_id = ?", current_user).find(params[:id])
    @ticket = current_user.tickets.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = current_user.tickets.create(ticket_params)
    if @ticket.persisted?
      flash[:green] = "Ticket created!"
      redirect_to tickets_path
    else
      render :new
    end
  end

  def update
    @ticket = current_user.tickets.find(params[:id])
    #binding.pry
    if @ticket.update_attributes(ticket_params)
      flash[:green] = "Ticket was successfully updated."
      redirect_to @ticket
    else
      render :edit
    end
  end

  def destroy
    current_user.tickets.find(params[:id]).destroy
    flash[:green] = "Ticket deleted."
    redirect_to tickets_url
  end
  
  private
  
    def get_all_tickets
      @all_mixed = current_user
        .tickets
        .paginate(page: params[:page])
        .order('date_opened DESC')
    end
  
    def get_all_unsolved
      @all_unsolved = current_user
        .tickets
        .where("status = ? or status = ? or status = ?", 'OP', 'IP', "WF")
        .paginate(page: params[:page])
        .order('severity = "asap" DESC',
               'severity = "high" DESC',
               'severity = "normal" DESC',
               'severity = "low" DESC',
               'date_opened ASC')
    end 
    
    def get_all_aborted
      @tickets_aborted = current_user.tickets.where("status = ?", 'AB')
        .order('date_opened DESC')
    end
    
    def get_all_solved
      @tickets_solved = current_user.tickets.where("status = ?", 'CL')
        .order('date_opened DESC')
    end
    
    def get_all_in_progress
      @tickets_solved = current_user.tickets.where("status = ?", 'IP')
        .order('date_opened DESC')
    end
    
    def get_all_ticket_categories
      @ticket_categories = current_user.ticket_categories.order("name ASC")
    end
    
    def get_users
      #@users = User.where("owner_id = ?", current_user).order('lastname ASC')
      @users = current_user.users.order('lastname ASC')
    end
    
    def ticket_params
      params.require(:ticket).permit(
        :ticket_category_id, 
        :issue, 
        :user_id, 
        :date_opened, 
        :date_closed, 
        :explanation, 
        :status, 
        :severity, 
        :remedy, 
        :owner_id
      )
    end
    
    def correct_user
      @ticket = current_user.tickets.find_by(id: params[:id])
      redirect_to root_url if @ticket.nil?
    end

end
