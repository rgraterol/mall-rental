class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :update_user, :edit_user, :delete_user]
  before_action :set_roles, only: [:new_user, :edit_user]
  @@password = ""

  def new_user
    unless user_signed_in?
      redirect_to root_url and return
    end
    @user ||= User.new
    authorize! :new, User
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
          set_roles
          format.html { render :new_user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url and return
    end
    authorize! :create, User
  end

  def show
    @pass = @@password
    @@password = ""
    authorize! :show, User
  end

  def index
    unless user_signed_in?
      redirect_to root_url and return
    end
    authorize! :show, User
  end

  def edit_user
    unless user_signed_in?
      redirect_to root_url and return
    end

    authorize! :update, User
  end

  def update_user
    if user_signed_in?
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_show_path(@user), notice: 'Usuario actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @user }
        else
          set_roles
          format.html { render :edit_user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
    authorize! :update, User
  end

  def delete_user
    if user_signed_in?
      if @user.destroy
        redirect_to users_index_path, alert: 'Usuario eliminado satisfactoriamente.' and return
      end
    end
    authorize! :update, User
  end

  private
    def set_roles
      @roles = Role.where(role_type: Role.role_types[:administrador_cliente])
      if @roles.blank?
        redirect_to new_role_path, alert: 'No existen roles para Administradores Mall.' and return
      end
    end

end