class BancosController < ApplicationController
  before_action :set_banco, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bancos = Banco.all
  end

  def show

  end

  def new
    @banco = Banco.new

  end

  def edit
  end

  def create
    @banco = Banco.new(banco_params)
    respond_to do |format|
      if @banco.save
        format.html { redirect_to bancos_path, notice: 'Banco fue guardado satisfactoriamente.' }
        format.json { render :index, status: :created, location: @banco }
      else
        format.html { render :new }
        format.json { render json: @banco.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @banco.update(banco_params)
        format.html { redirect_to bancos_path, notice: 'Banco fue actualizado satisfactoriamente.' }
        format.json { render :index, status: :ok, location: @banco }
      else
        format.html { render :new }
        format.json { render json: @banco.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @banco.destroy
    respond_to do |format|
      format.html { redirect_to bancos_url, notice: 'Banco se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_banco
      @banco = Banco.find(params[:id])
    end

    def banco_params
      params.require(:banco).permit(:nombre)
    end
end
