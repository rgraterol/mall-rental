class CuentaBancariaController < ApplicationController
  before_action :set_cuenta_bancarium, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cuenta_bancaria = CuentaBancarium.all
    respond_with(@cuenta_bancaria)
  end

  def show
    respond_with(@cuenta_bancarium)
  end

  def new
    @cuenta_bancarium = CuentaBancarium.new
    respond_with(@cuenta_bancarium)
  end

  def edit
  end

  def create
    @cuenta_bancarium = CuentaBancarium.new(cuenta_bancarium_params)
    @cuenta_bancarium.save
    respond_with(@cuenta_bancarium)
  end

  def update
    @cuenta_bancarium.update(cuenta_bancarium_params)
    respond_with(@cuenta_bancarium)
  end

  def destroy
    @cuenta_bancarium.destroy
    respond_with(@cuenta_bancarium)
  end

  private
    def set_cuenta_bancarium
      @cuenta_bancarium = CuentaBancarium.find(params[:id])
    end

    def cuenta_bancarium_params
      params.require(:cuenta_bancarium).permit(:nro_cta, :tipo_cuenta, :beneficiario, :doc_identidad, :banco_id)
    end
end
