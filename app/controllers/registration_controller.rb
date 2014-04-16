#class RegistrationController < ApplicationController
#end

class RegistrationController < Devise::RegistrationsController

  def new
    @user= User.new
  end

  def create
    @user = User.new(user_params)
    @user.valid?
    if @user.errors.blank?
      @user.save
      redirect_to dashboard_path
    else
      render :action => "new"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end

end