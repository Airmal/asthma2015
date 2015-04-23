class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end


 # def create

 #    super
 #    respond_to do |format|
 #      format.html { render "http://smw.gensee.com/webcast/site/entry/join-d6986b963f6f428ba4a09d4f2ff425a2" }
 #    end
 #  end


  # POST /resource
  def create

    if User.all.size >= 300
      return
    end  

    # @user = build_resource(sign_up_params)
    build_resource(sign_up_params)
    # 统一事务
    # ActiveRecord::Base.transaction do
      # 用户表更新
      resource.save

    #   if !@user.invitate_cd.empty?
    #     # 邀请码表更新
    #     @invitate = Invitate.find_by invitate_cd: @user.invitate_cd
    #     @invitate.invitate_flg = 2
    #     @invitate.use_time = Time.now
    #     @invitate.save

    #     # 预约表更新
    #     @appointment = Appointment.new
    #     @appointment.user_id = @user.id
    #     @appointment.program_id = @invitate.program_id
    #     @appointment.invitate_cd = @user.invitate_cd
    #     @appointment.save
    #   end
    # end
    yield resource if block_given?
    if resource.persisted?
      a
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      # set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
