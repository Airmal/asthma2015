class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    respond_to do |format|
      if !resource_params[:email].nil?
        User.find_by(:email => resource_params[:email]).reset_password!(resource_params[:password], resource_params[:password_confirmation]) 
        format.html { redirect_to "/users/sign_in" }
        format.json { render json: { :result => "success" } }
      else
        format.html { redirect_to "/users/password/new" }
        format.json { render json: { :result => "failure" } }
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
