class BancosController < ApplicationController
  before_action :set_banco, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bancos = Banco.all
    respond_with(@bancos)
  end

  def show
    respond_with(@banco)
  end

  def new
    @banco = Banco.new
    respond_with(@banco)
  end

  def edit
  end

  def create
    @banco = Banco.new(banco_params)
    @banco.save
    respond_with(@banco)
  end

  def update
    @banco.update(banco_params)
    respond_with(@banco)
  end

  def destroy
    @banco.destroy
    respond_with(@banco)
  end

  private
    def set_banco
      @banco = Banco.find(params[:id])
    end

    def banco_params
      params.require(:banco).permit(:nombre)
    end
end
