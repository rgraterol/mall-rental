class VentasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_venta, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @user_tienda = current_user.tienda
    if @user_tienda.blank?
      authorize! :index, root_url, :message => "Debe tener una tienda asignada."
    end

    @tienda_id = params[:tienda_id]
    @month = params[:month]
    @today = Time.now
    @year == @today.strftime("%Y")
    @month = Date.new(@year.to_i,@month.to_i,1)
    if @tienda_id.nil?
      @tienda_id = current_user.tienda
      @ventas_mall = false
    else
      @ventas_mall = true
    end

    @tienda = Tienda.find(@tienda_id)
    @local = Local.find(@tienda.local_id)
    @ventas = Venta.where(tienda_id: @tienda.id)
    @contrato_alquiler = ContratoAlquiler.where(tienda: @tienda)
  end

  def cobranza
=begin
    @mall = current_user.mall
    @tiendas = Tienda.where(mall: @mall)
    raise @tiendas.inspect
    @ventas = Venta.where(tienda_id: @tienda.id)
    @contrato_alquiler = ContratoAlquiler.where(tienda: @tienda)
=end
  end

  def mall_tiendas
    if !params[:acceso].nil?
      @acceso = params[:acceso]
      @month = params[:month]
      @today = Time.now
      @year == @today.strftime("%Y")
      @month = Date.new(@year.to_i,@month.to_i,1)
    else
      @acceso = 1

    end
  end

  def  mensuales
    @mall = current_user.mall
  end


=begin
  def mes

    @tienda = current_user.mall.tiendas.first

    @ventas = Venta.where(tienda_id: @tienda_id)
    @contrato_alquiler = ContratoAlquiler.where(tienda: @tienda)
  end
=end

  def show
  end

  def new
    @venta = Venta.new
  end

  def edit
  end

  def create

  end

  def update

  end

  def destroy

  end

  private
  def set_venta
    @venta = current_user.tienda.ventas.find_by(id: params[:id])
  end

  def venta_params
    params.require(:venta).permit(:fecha, :monto_ml, :monto_usd, :tienda)
  end
end
