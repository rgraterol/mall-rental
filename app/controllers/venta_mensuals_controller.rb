class VentaMensualsController < ApplicationController
  before_action :set_venta_mensual, only: [:show, :edit, :update, :destroy]

  def index
    @venta_mensuals = VentaMensual.all
  end

  def show
  end

  def new
    @venta_mensual = VentaMensual.new
  end

  def edit
  end

  def create
    @venta_mensual = VentaMensual.new(venta_mensual_params)
    @venta_mensual.save
  end

  def update
    @venta_mensual.update(venta_mensual_params)
  end

  def destroy
    @venta_mensual.destroy
  end

  private
    def set_venta_mensual
      @venta_mensual = VentaMensual.find(params[:id])
    end

    def venta_mensual_params
      params.require(:venta_mensual).permit(:anio, :mes, :monto, :montoNotasCredito, :montoBruto, :montoBrutoUSD, :montoCostoVenta, :montoNeto, :montoNetoUSD, :editable)
    end
end
