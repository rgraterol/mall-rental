class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @clientes = current_user.mall.clientes
    if @clientes.blank?
      redirect_to new_cliente_path
    end
  end

  def new
    @cliente = Cliente.new
    @locals = Local.where(mall_id: current_user.mall.id)
  end

  def create
    @cliente = Cliente.new cliente_params.merge(mall_id: current_user.mall_id)
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to clientes_path, notice: 'Cliente fue creado existosamente.' }
        format.json { render :index, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to clientes_path, notice: 'Cliente fue actualizado exitosamente.' }
        format.json { render :index, status: :created, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cliente.destroy
    respond_with(@cliente)
  end

  def show
  end

  private
  def set_cliente
    @cliente = current_user.mall.clientes.find_by(id: params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:nombre, :RIF, :direccion, :telefono, :nombre_rl, :profesion_rl, :cedula_rl, :email_rl, :telefono_rl, :nombre_contacto, :profesion_contacto, :cedula_contacto, :email_contacto, :telefono_contacto, :mall_id, :tipo_servicio_id)
  end
end
