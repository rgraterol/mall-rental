class CambioMonedasController < ApplicationController
  before_action :set_cambio_moneda, only: [:show, :edit, :update, :destroy]

  # GET /cambio_monedas
  # GET /cambio_monedas.json
  def index
    @cambio_monedas = CambioMoneda.all
  end

  # GET /cambio_monedas/1
  # GET /cambio_monedas/1.json
  def show
  end

  # GET /cambio_monedas/new
  def new
    @cambio_moneda = CambioMoneda.new
  end

  # GET /cambio_monedas/1/edit
  def edit
  end

  # POST /cambio_monedas
  # POST /cambio_monedas.json
  def create
    @cambio_moneda = CambioMoneda.new(cambio_moneda_params)

    respond_to do |format|
      if @cambio_moneda.save
        format.html { redirect_to @cambio_moneda, notice: 'Cambio moneda fue creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @cambio_moneda }
      else
        format.html { render :new }
        format.json { render json: @cambio_moneda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cambio_monedas/1
  # PATCH/PUT /cambio_monedas/1.json
  def update
    respond_to do |format|
      if @cambio_moneda.update(cambio_moneda_params)
        format.html { redirect_to @cambio_moneda, notice: 'Cambio moneda fue actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @cambio_moneda }
      else
        format.html { render :edit }
        format.json { render json: @cambio_moneda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cambio_monedas/1
  # DELETE /cambio_monedas/1.json
  def destroy
    @cambio_moneda.destroy
    respond_to do |format|
      format.html { redirect_to cambio_monedas_url, notice: 'Cambio moneda was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mf_cambio_moneda
    usd = (params[:ml].to_i / CambioMoneda.last.cambio_ml_x_usd).round(2)
    render json: usd
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cambio_moneda
      @cambio_moneda = CambioMoneda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cambio_moneda_params
      params.require(:cambio_moneda).permit(:fecha, :cambio_ml_x_usd)
    end
end
