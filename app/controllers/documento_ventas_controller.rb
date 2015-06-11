class DocumentoVentasController < ApplicationController
  before_action :set_documento_venta, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @documento_ventas = DocumentoVenta.all
    respond_with(@documento_ventas)
  end

  def show
    respond_with(@documento_venta)
  end

  def new
    @documento_venta = DocumentoVenta.new
    respond_with(@documento_venta)
  end

  def edit
  end

  def create
    @documento_venta = DocumentoVenta.new(documento_venta_params)
    @documento_venta.save
    respond_with(@documento_venta)
  end

  def update
    @documento_venta.update(documento_venta_params)
    respond_with(@documento_venta)
  end

  def destroy
    @documento_venta.destroy
    respond_with(@documento_venta)
  end

  private
    def set_documento_venta
      @documento_venta = DocumentoVenta.find(params[:id])
    end

    def documento_venta_params
      params.require(:documento_venta).permit(:titulo, :nombre)
    end
end
