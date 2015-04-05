class Users::MallUsersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :mall_user
  before_action :set_user, only: [:destroy]

  def index
    @mall_users = User.joins(:role).where(mall_id: current_user.mall.id, roles: {role_type: [Role.role_types[:cliente_mall],Role.role_types[:cliente_sistema] ]})
  end

  def new
    @mall_user ||= User.new
    @roles = Role.where(role_type: Role.role_types[:cliente_mall])
  end

  def create
    @mall_user = User.new(mall_user_params.merge(mall_id: current_user.mall.id))
    @@password = mall_user_params[:password]
    respond_to do |format|
      if @mall_user.save
        PasswordMailer.send_password(@mall_user, @@password).deliver
        format.html { redirect_to  user_show_path(@mall_user), notice: 'El usuario de MallRental se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @mall_user }
      else
        format.html { render :newr }
        format.json { render json: @mall_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.mall.id == current_user.mall.id && (@user.role.cliente_mall? || @user.role.cliente_sistema?)
      if @user.destroy
        redirect_to mall_users_path, alert: 'Usuario eliminado satisfactoriamente.' and return
      end
    else
      redirect_to mall_users_path, alert: 'No Autorizado' and return
    end
  end

  private
    def mall_user_params
      params.require(:user).permit(:name, :username, :email, :password, :cellphone, :role_id)
    end

    def self.permission
      'mall_user'
    end
end