class Users::RegistrationsController < Devise::RegistrationsController

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

  private

  def user_params
    params.require(:user).permit(:username, :password,  :email)#, rol_ids: [])
  end
end