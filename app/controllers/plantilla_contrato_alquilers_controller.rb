class PlantillaContratoAlquilersController < ApplicationController
  before_action :set_plantilla_contrato_alquiler, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @plantilla_contrato_alquilers = PlantillaContratoAlquiler.all

  end

  def show

    @nombre_arrendatario = 'LERY PICON'

  end

  def new
    @plantilla_contrato_alquiler = PlantillaContratoAlquiler.new

  end

  def edit
  end

  def create
    @plantilla_contrato_alquiler = PlantillaContratoAlquiler.new(plantilla_contrato_alquiler_params)

    respond_to do |format|
      if @plantilla_contrato_alquiler.save
        format.html { redirect_to plantilla_contrato_alquilers_path, notice: 'Plantilla de Contrato Alquiler fue creada satisfactoriamente.' }
        format.json { render :index, status: :created, location: @plantilla_contrato_alquiler }
      else
        format.html { render :new }
        format.json { render json: @plantilla_contrato_alquiler.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @plantilla_contrato_alquiler.update(plantilla_contrato_alquiler_params)
        format.html { redirect_to plantilla_contrato_alquilers_path, notice: 'Plantilla de Contrato Alquiler fue actualizada satisfactoriamente.' }
        format.json { render :index, status: :ok, location: @plantilla_contrato_alquiler }
      else
        format.html { render :new }
        format.json { render json: @plantilla_contrato_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @plantilla_contrato_alquiler.destroy
    respond_to do |format|
      format.html { redirect_to plantilla_contrato_alquilers_url, notice: 'Plantilla de Contrato Alquiler se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_plantilla_contrato_alquiler
      @plantilla_contrato_alquiler = PlantillaContratoAlquiler.find(params[:id])
    end

    def plantilla_contrato_alquiler_params
      params.require(:plantilla_contrato_alquiler).permit(:nombre, :contenido, :mall_id, :tipo_canon_alquiler_id)
    end
end
