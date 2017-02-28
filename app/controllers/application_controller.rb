class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :active?
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
    data_services_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def active?(tab)
    if request.env['PATH_INFO'].include?(tab)
      "active"
    else
      ""
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password])
  end

end
