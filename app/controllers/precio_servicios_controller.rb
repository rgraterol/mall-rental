class PrecioServiciosController < ApplicationController
  before_action :set_precio_servicio, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @precio_servicios = PrecioServicio.all
    if @precio_servicios.blank?
      redirect_to controller: 'precio_servicios', action: 'new'
    end
  end

  def show

  end

  def new
    @precio_servicio = PrecioServicio.new
    @mall = current_user.mall
  end

  def edit
    @mall = current_user.mall
  end

  def create
    @precio_servicio = PrecioServicio.new(precio_servicio_params)
    respond_to do |format|
      if @precio_servicio.save
        format.html { redirect_to precio_servicios_path, notice: 'Precio de Servicio fue guardado satisfactoriamente.' }
        format.json { render :index, status: :created, location: @precio_servicio }
      else
        format.html { render :new }
        format.json { render json: @precio_servicio.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @precio_servicio.update(precio_servicio_params)
        format.html { redirect_to precio_servicios_path, notice: 'Precio del Servicio fue actualizado satisfactoriamente.' }
        format.json { render :index, status: :ok, location: @precio_servicio }
      else
        format.html { render :edit }
        format.json { render json: @precio_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @precio_servicio.destroy
    respond_to do |format|
      format.html { redirect_to precio_servicios_url, notice: 'Precio del Servicio se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_precio_servicio
      @precio_servicio = PrecioServicio.find(params[:id])
    end

    def precio_servicio_params
      params.require(:precio_servicio).permit(:fecha, :precio_usd, :tipo_contrato_servicio_id, :tipo_servicio_id)
    end
end
