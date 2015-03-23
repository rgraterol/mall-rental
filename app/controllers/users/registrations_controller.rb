class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :update_user, :edit_user, :delete_user]
  @@password = ""

  def new_user
    unless user_signed_in?
      redirect_to root_url and return
    end
    @user ||= User.new
  end

  def create_user
    if signed_in?
      @user = User.new(user_params)
      @@password = user_params[:password]
      respond_to do |format|
        if @user.save
          PasswordMailer.send_password(@user, @@password).deliver
          format.html { redirect_to  user_show_path(@user), notice: 'El usuario de MallRental se ha creado exitosamente.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new_user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url and return
    end
  end

  def show
    @pass = @@password
    @@password = ""
  end

  def index
    unless user_signed_in?
      redirect_to root_url and return
    end
  end

  def edit_user
    unless user_signed_in?
      redirect_to root_url and return
    end
  end

  def update_user
    if user_signed_in?
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_show_path(@user), notice: 'Usuario actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit_user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def delete_user
    if user_signed_in?
      if @user.destroy
        redirect_to users_index_path, alert: 'Usuario eliminado satisfactoriamente.' and return
      end
    end
  end

  private

    def set_user
      @user = User.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)#, rol_ids: [])
    end
end