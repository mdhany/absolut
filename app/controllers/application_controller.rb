class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  #layout 'admin'
  layout :layout_by_resource

  helper_method :current_customer

  def destroy_session_customer
    session[:customer_id] = nil
    session[:token_fb] = nil
    session[:gift] = nil
  end

  def after_sign_in_path_for(resource)
    if params.has_key?('collector')
      events_collector_path
    else
      entries_path
    end
  end

  private


  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

  protected
  def layout_by_resource
    if devise_controller? && controller_name == 'sessions' && action_name == 'new' || controller_name == 'passwords' && action_name == 'new' || controller_name == 'collectors' && action_name == 'event'
      'login'
    elsif controller_name == 'mobile'
      'application'
    else
      'admin'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:event_id, :name, :email, :password, :password_confirmation, :current_password) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:event_id, :name, :email, :password, :password_confirmation) }
  end
end
