class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # filter for timezone setup
  around_filter :user_time_zone, if: :current_user
  
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
    # Set timezone to Athens If current_user.time_zone not set
    def user_time_zone(&block)
      time_zone = current_user.try(:time_zone) || 'Athens'
      Time.use_zone(time_zone, &block)
    end
  
end
