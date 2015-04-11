class CanonAlquilersController < ApplicationController
  before_action :set_canon_alquiler, only: [:show, :edit, :update, :destroy]

  # GET /canon_alquilers
  # GET /canon_alquilers.json
  def index
    @canon_alquilers = CanonAlquiler.all
  end

  # GET /canon_alquilers/1
  # GET /canon_alquilers/1.json
  def show
  end

  # GET /canon_alquilers/new
  def new
    @canon_alquiler = CanonAlquiler.new
  end

  # GET /canon_alquilers/1/edit
  def edit
  end

  # POST /canon_alquilers
  # POST /canon_alquilers.json
  def create

    @canon_alquiler = CanonAlquiler.new(canon_alquiler_params)
    @canon_alquiler.canon_fijo_usd = calculate_canon_usd(@canon_alquiler.canon_fijo_ml)

    respond_to do |format|
      if @canon_alquiler.save
        format.html { redirect_to @canon_alquiler, notice: 'Canon alquiler se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @canon_alquiler }
      else
        format.html { render :new }
        format.json { render json: @canon_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /canon_alquilers/1
  # PATCH/PUT /canon_alquilers/1.json
  def update
    @canon_alquiler.canon_fijo_ml = canon_alquiler_params[:canon_fijo_ml]
    @canon_fijo_usd = calculate_canon_usd(@canon_alquiler.canon_fijo_ml)
    respond_to do |format|
      if @canon_alquiler.update(canon_alquiler_params)
         @canon_alquiler.update(canon_fijo_usd: @canon_fijo_usd)
        format.html { redirect_to @canon_alquiler, notice: 'Canon alquiler se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @canon_alquiler }
      else
        format.html { render :edit }
        format.json { render json: @canon_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canon_alquilers/1
  # DELETE /canon_alquilers/1.json
  def destroy
    @canon_alquiler.destroy
    respond_to do |format|
      format.html { redirect_to canon_alquilers_url, notice: 'Canon alquiler se ha eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canon_alquiler
      @canon_alquiler = CanonAlquiler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def canon_alquiler_params
      params.require(:canon_alquiler).permit(:fecha, :canon_fijo_ml, :canon_fijo_usd, :porc_canon_ventas, :monto_minimo_ventas)
    end

    def calculate_canon_usd(canon_fijo_ml)

      @cm = CambioMoneda.all.order('fecha desc')[0]

      if @cm
        @cambio_ml_x_usd = @cm.cambio_ml_x_usd
        @canon_fijo_usd =  canon_fijo_ml*@cambio_ml_x_usd
        return @canon_fijo_usd
      end

    end
end
