class TiendasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tienda, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @tiendas = current_user.mall.tiendas
  end

  def show
  end

  def new
    @tienda = Tienda.new
    @contrato_alquiler = @tienda.contrato_alquilers.build
  end

  def edit
    @contrato_alquiler = @tienda.contrato_alquilers.last
  end

  def create
    @tienda = Tienda.new(tienda_params)
    respond_to do |format|
      if @tienda.save
        format.html { redirect_to tiendas_path, notice: 'Tienda creada satisfactoriamente.' }
        format.json { render action: 'show', status: :created, location: @tienda }
      else
        format.html { render action: 'new' }
        format.json { render json: @tienda.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tienda.update(tienda_params)
        format.html { redirect_to tiendas_path, notice: 'Tienda actualizada satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tienda.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tienda.destroy
    respond_to do |format|
      format.html { redirect_to tiendas_url }
      format.json { head :no_content }
    end
  end

  private
    def set_tienda
      @tienda = current_user.mall.tiendas.find_by(id: params[:id])
    end

    def tienda_params
      params.require(:tienda).permit(:local_id, :arrendatario_id, :actividad_economica_id, contrato_alquilers_attributes: [ :id, :tipo_canon_alquiler, :fecha_inicio, :fecha_fin, :archivo_contrato, :canon_fijo_ml, :canon_fijo_usd, :porc_canon_ventas, :monto_minimo_ventas])
    end
end
