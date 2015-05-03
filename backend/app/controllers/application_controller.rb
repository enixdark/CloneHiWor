class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # authorize_resource
  
  protect_from_forgery #with: :exception

  # before_filter :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      if request.path =~ /^\/admins$/
        redirect_to '/admin/sign_in'
      else
        redirect_to login_url, alert: "Please log in to continue."
      end
    else
      if request.env["HTTP_REFERER"].present?
        redirect_to :back, :alert => exception.message
      else
        render :file => "#{Rails.root}/public/404.html",
        :status => 404, :layout => false
      end
    end
  end

  protected
  	def configure_permitted_parameters
	  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, 
                                                :password_confirmation, :remember_me) }
	  	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:signin, :username, 
                                                  :email, :password, :remember_me) }
	  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, 
                                                      :password_confirmation, :current_password) }
	  end
end
