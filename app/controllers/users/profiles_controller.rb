class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def profile
    
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to profile_path, notice: 'Su perfil ha sido actualizado.' }
        format.json { render :profile, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :avatar, :name, :cellphone)
    end

end