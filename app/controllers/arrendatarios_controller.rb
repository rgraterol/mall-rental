class ArrendatariosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_arrendatario, only: [:edit, :show, :update, :destroy]
  load_and_authorize_resource

  respond_to :html


  def index
    @arrendatarios = Arrendatario.all
    if @arrendatarios.blank?
      redirect_to new_arrendatario_path
    end
  end

  def new
    @arrendatario = Arrendatario.new
  end

  def create
    @arrendatario = Arrendatario.new arrendatario_params
    @arrendatario.save
    respond_with(@arrendatario)
  end

  def edit
  end

  def update
    @arrendatario.update(arrendatario_params)
    respond_with(@arrendatario)
  end

  def destroy
    @arrendatario.destroy
    respond_with(@arrendatario)
  end

  def show
  end

  private
    def set_arrendatario
      @arrendatario = current_user.mall.arrendatarios.find_by(id: params[:id])
    end

    def arrendatario_params
      params.require(:arrendatario).permit(:local_id, :nombre, :rif, :direccion, :telefono, :actividad_economica_id, :nombre_rl, :cedula_rl, :email_rl, :telefono_rl)
    end
end