class PagoAlquilersController < ApplicationController
  before_action :set_pago_alquiler, only: [:show, :edit, :update, :destroy]

  # GET /pago_alquilers
  # GET /pago_alquilers.json
  def index
    @pago_alquilers = PagoAlquiler.all
  end

  # GET /pago_alquilers/1
  # GET /pago_alquilers/1.json
  def show
  end

  # GET /pago_alquilers/new
  def new_transferencia
    @pago_alquiler = PagoAlquiler.new
  end

  # GET /pago_alquilers/1/edit
  def edit
  end

  # POST /pago_alquilers
  # POST /pago_alquilers.json
  def create
    @pago_alquiler = PagoAlquiler.new(pago_alquiler_params)

    respond_to do |format|
      if @pago_alquiler.save
        format.html { redirect_to @pago_alquiler, notice: 'Pago alquiler was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pago_alquiler }
      else
        format.html { render action: 'new' }
        format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pago_alquilers/1
  # PATCH/PUT /pago_alquilers/1.json
  def update
    respond_to do |format|
      if @pago_alquiler.update(pago_alquiler_params)
        format.html { redirect_to @pago_alquiler, notice: 'Pago alquiler was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pago_alquilers/1
  # DELETE /pago_alquilers/1.json
  def destroy
    @pago_alquiler.destroy
    respond_to do |format|
      format.html { redirect_to pago_alquilers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pago_alquiler
      @pago_alquiler = PagoAlquiler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pago_alquiler_params
      params[:pago_alquiler]
    end
end
