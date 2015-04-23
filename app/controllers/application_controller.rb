class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location

  def require_user_login
    if current_user.blank?
      respond_to do |format|
        format.html { authenticate_user! }
        format.json { head(:unauthorized) }
      end
    end
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        request.path != "/admins/sign_in" &&
        request.path != "/admins/sign_up" &&
        request.path != "/admins/password/new" &&
        request.path != "/admins/password/edit" &&
        request.path != "/admins/confirmation" &&
        request.path != "/admins/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end
  
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def check_login
    login = params[:login]
    respond_to do |format|
      if !login.match(/^((\(\d{2,3}\))|(\d{3}\-))?1[3,8,5]{1}\d{9}$/).nil?
        if User.find_by_mobile(params[:login]).nil?
          format.json { render json: { :result => "success" } }
        else
          format.json { render json: { :result => "failure" } }
        end
      elsif !login.match(/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/).nil?
        if User.find_by_email(params[:login]).nil?
          format.json { render json: { :result => "success" } }
        else
          format.json { render json: { :result => "failure" } }
        end
      else
        if User.find_by_username(params[:login]).nil?
          format.json { render json: { :result => "success" } }
        else
          format.json { render json: { :result => "failure" } }
        end
      end
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :mobile, :password, :invitate_cd) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :mobile, :password, :remember_me) }
    end
end
