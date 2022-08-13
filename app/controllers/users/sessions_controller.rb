# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "loginlayout"
  protect_from_forgery except: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
   #   super
   @u=User.findby(configure_sign_in_params)
   if !@u
     render :identifiantinconnu
   else
     bypass_sign_in @u
     redirect_to "/mon-compte"
   end
  end

  # DELETE /resource/sign_out
 def destroyuser
   if user_signed_in?
  sign_out(current_user)
  p user_signed_in?
   end
  redirect_to(request.env['HTTP_REFERER'])

 
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
 def configure_sign_in_params
     params.permit(:log,:pwd)
  end
end
