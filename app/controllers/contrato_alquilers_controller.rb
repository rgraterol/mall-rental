class ContratoAlquilersController < ApplicationController
  before_action :set_contrato_alquiler, only: [:show, :edit, :update, :destroy]
  before_action :set_tienda, only: [:index, :new, :create, :destroy, :show, :edit, :update]
  before_action :set_contrato_alquiler, only: [:destroy, :show, :edit, :update]

  # GET /contrato_alquilers
  # GET /contrato_alquilers.json
  def index
    @contrato_alquilers = @tienda.contrato_alquilers
  end

  # GET /contrato_alquilers/1
  # GET /contrato_alquilers/1.json
  def show
  end

  # GET /contrato_alquilers/new
  def new
    @contrato_alquiler = ContratoAlquiler.new
  end

  # GET /contrato_alquilers/1/edit
  # def edit
  # end

  # POST /contrato_alquilers
  # POST /contrato_alquilers.json
  def create
    @contrato_alquiler = ContratoAlquiler.new(contrato_alquiler_params)

    respond_to do |format|
      if @contrato_alquiler.save
        format.html { redirect_to @contrato_alquiler, notice: 'Contrato alquiler was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contrato_alquiler }
      else
        format.html { render action: 'new' }
        format.json { render json: @contrato_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contrato_alquilers/1
  # PATCH/PUT /contrato_alquilers/1.json
  # def update
  #   respond_to do |format|
  #     if @contrato_alquiler.update(contrato_alquiler_params)
  #       format.html { redirect_to @contrato_alquiler, notice: 'Contrato alquiler was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @contrato_alquiler.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /contrato_alquilers/1
  # DELETE /contrato_alquilers/1.json
  def destroy
    @contrato_alquiler.destroy
    respond_to do |format|
      format.html { redirect_to contrato_alquilers_url }
      format.json { head :no_content }
    end
  end

  private

    def set_tienda
      @tienda = current_user.mall.tiendas.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def set_contrato_alquiler
      @contrato_alquiler = @tienda.contrato_alquilers.find_by(id: ActionController::Parameters.new(ca: params[:ca]).permit(:ca)[:ca])
    end

    def contrato_alquiler_params
      params.require(:contrato_alquiler).permit(:nro_contrato, :fecha_inicio, :fecha_fin, :archivo_contrato, :canon_fijo_ml, :canon_fijo_usd, :porc_canon_ventas, :estado_contrato, :tipo_canon_alquiler, :tienda_id)
    end
end
