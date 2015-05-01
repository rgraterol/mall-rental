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
    @tienda = current_user.tienda
    if @tienda.blank?
      authorize! :index, root_url, :message => "Debe tener una tienda asignada."
    end
    @pago_alquiler = PagoAlquiler.new
  end

  # GET /pago_alquilers/1/edit
  def edit
  end

  # POST /pago_alquilers
  # POST /pago_alquilers.json
  def create
    #raise pago_alquiler_params.inspect
    @pago_alquiler = PagoAlquiler.new(pago_alquiler_params)

    @tienda_id = current_user.tienda
    @mes_alquiler = params[:pago_alquiler]['mes_alquiler']
    @anio_alquiler = params[:pago_alquiler]['anio_alquiler']

    @pago = PagoAlquiler.where('tienda_id = ?',@tienda_id)
    if @pago.blank?
      #redirect_to  registrar_pago_transferencia_path, notice: 'La tienda no tiene recibo guardado.'
      flash[:danger] = 'La tienda no tiene recibos guardados.'
      render :action=>'new_transferencia'
    elsif
      @pago = PagoAlquiler.where('tienda_id = ? AND pagado = ?',@tienda_id.id, FALSE)
      if @pago.blank?
        flash[:danger] = 'La tienda no tiene recibos por pagar.'
        render :action=>'index'
      elsif
        @pago = PagoAlquiler.where('tienda_id = ? AND pagado = ? AND anio_alquiler = ? AND mes_alquiler = ?',@tienda_id,FALSE,@anio_alquiler.to_i, @mes_alquiler.to_i)
        if @pago.blank?
          flash[:danger] = 'El mes y año a pagar no corresponde al que debe pagar.'
          render :action=>'new_transferencia'
        else
          @pago = @pago.last
          @monto_alquiler = @pago.monto_alquiler_ml

          if @monto_alquiler.to_f != params[:pago_alquiler]['monto_alquiler_ml'].to_f
            flash[:danger] = 'El monto de transferencia no corresponde al monto del canon.'
            render :action=>'new_transferencia'
          else
            @cuenta_bancaria = CuentaBancarium.find(params[:pago_alquiler]['cuenta_bancaria_id'])
            @contrato_alquiler = ContratoAlquiler.find_by(tienda_id: @tienda_id)
            @obj = {
                :fecha_pago => params[:pago_alquiler]['fecha_pago'],
                :nro_cheque_confirmacion => params[:pago_alquiler]['nro_cheque_confirmacion'],
                :cuenta_bancaria_id => params[:pago_alquiler]['cuenta_bancaria_id'],
                :pagado => TRUE,
                :nombre_banco => @cuenta_bancaria.banco.nombre,
                :facturado => FALSE,
                :tipo_pago => 1,
                :contrato_alquiler_id => @contrato_alquiler.id,
            }
            @pago_alquiler = @obj

            respond_to do |format|
              if @pago.update(@pago_alquiler)
                format.html { redirect_to pago_alquilers_url, notice: 'Pago alquiler se guardo correctamente.' }
                format.json { head :no_content }
              else
                format.html { render action: 'new_transferencia' }
                format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
              end
            end
          end
        end
      end
    end
  end

  # PATCH/PUT /pago_alquilers/1
  # PATCH/PUT /pago_alquilers/1.json
  def update
    respond_to do |format|
      if @pago_alquiler.update(pago_alquiler_params)
        format.html { redirect_to pago_alquilers_url, notice: 'Pago alquiler se guardo fino.' }
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
      params.require(:pago_alquiler).permit(:mes_alquiler,:anio_alquiler, :cuenta_bancaria_id, :monto_alquiler_ml, :fecha_pago, :nro_cheque_confirmacion)

=begin
      nro_recibo: @nro_recibo, fecha_recibo_cobro: @fecha_recibo,
          anio_alquiler: @anio_alquiler, mes_alquiler: @mes_alquiler,
          monto_canon_fijo_ml: @monto_canon_fijo_ml, monto_porc_ventas_ml: @monto_porc_ventas,
          monto_alquiler_ml: @monto_alquiler, monto_alquiler_usd: @monto_alquiler, pagado: @pagado,
          tienda_id: tienda)
      if @pago.save
=end


    end
end
