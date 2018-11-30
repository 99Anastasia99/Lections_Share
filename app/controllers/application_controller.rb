class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    elsif cookies[:locale]
      I18n.locale = cookies[:locale]
    else I18n.locale = I18n.locale.default
    end
    cookies[:locale] = I18n.locale
  end

  def set_locale_cookie
    cookies[:locale] = params[:locale]
    redirect_to root_path
  end
  
  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
