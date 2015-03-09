class DashboardController < ApplicationController
  include TicketsHelper
    
  before_action :logged_in_user, only: [:index]
    
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
      .where(owner_id: current_user.users)
    @tickets_by_wday = current_user.tickets
      .where("dayofweek(date_opened) >= 2")
      .group("dayofweek(date_opened)")
      .count
      .transform_keys{|k| Date::DAYNAMES[k-1]}
    @tickets_by_month = current_user.tickets
      .group("month(date_opened)")
      .count
      .transform_keys{|k| Date::MONTHNAMES[k]}
    
    # Ticket per day of week chart data  
    @day_labels = @tickets_by_wday.map{|key,value|  key  }.to_a
    @day_values = @tickets_by_wday.map{|key,value| value }.to_a      
    
    gon.day_labels = @day_labels
    gon.day_values = @day_values
    
    # Ticket per month chart data 
    @month_labels = @tickets_by_month.map{|key,value|  key  }.to_a
    @month_values = @tickets_by_month.map{|key,value| value }.to_a      
    
    gon.mth_labels = @month_labels
    gon.mth_values = @month_values
    
  end  
    
end
