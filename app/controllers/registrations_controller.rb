class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  
 private
 def sign_up_params
  params.require(:user).permit(:firstname, :lastname, :phone, :email, :password, :password_confirmation)
 end

end
