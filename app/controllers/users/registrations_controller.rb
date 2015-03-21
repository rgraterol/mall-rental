class Users::RegistrationsController < Devise::RegistrationsController

  def new_user
    unless user_signed_in?
      redirect_to root_url and return
    end
    @user ||= User.new
  end

  def create_user

  end
end