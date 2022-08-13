# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  layout "loginlayout"
  protect_from_forgery except: [:create,:update]
  prepend_before_action :require_no_authentication, only: :cancel

  # GET /resource/password/new
 def new
  end

  # POST /resource/password
  def create
    #redirect_to mynewpassword_path(actions: "rp", login: params[:user_login], reset_password_token: "whatever")
    @user=User.find_by(email: params[:user_login])
    if @user
    p @user
    bypass_sign_in @user
    
      
          redirect_to checkmailconfirm_path(checkemail: "confirm")
    else
      render :erroradresse
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    p params
  end

  # PUT /resource/password
 def update
   if current_user && current_user.update(password: params[:pass1])
     render :reinit
   end
 end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
