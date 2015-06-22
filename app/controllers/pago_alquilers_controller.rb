class PagoAlquilersController < ApplicationController
  before_action :set_pago_alquiler, only: [:show, :edit, :update, :destroy]
  before_action :check_user_mall

  # GET /pago_alquilers
  # GET /pago_alquilers.json
  def index

    @tiendas = current_user.mall.tiendas
    #@cobranza_alquilers = CobranzaAlquiler.all
    @cobranza_alquilers = Array.new
    @today = Time.now
    @year = @today.strftime("%Y")
    @month = @today.strftime("%-m").to_i-1
    @suma_x_cobrar = 0
    @suma_monto_alquiler = 0
    @suma_monto_pagado = 0

    @tiendas.each do |tienda|
      @cobranza_alq = CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', @year,@month,tienda.id)

      if !@cobranza_alq.blank?
        @cobranza_alquilers.push(@cobranza_alq)
        @cobranza_alquilers.each do |cobranza|
          @suma_x_cobrar += cobranza.where('saldo_deudor != ?',0).sum(:monto_alquiler)
          @suma_monto_alquiler += cobranza.sum(:monto_alquiler)
          @suma_monto_pagado += (@suma_monto_alquiler - @suma_x_cobrar)
        end
      end
    end

    @suma_x_cobrar = ActionController::Base.helpers.number_to_currency(@suma_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    @suma_monto_pag = ActionController::Base.helpers.number_to_currency(@suma_monto_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    @suma_monto_alq = ActionController::Base.helpers.number_to_currency(@suma_monto_alquiler, separator: ',', delimiter: '.', format: "%n %u", unit: "")

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
    @local = Local.find(@tienda.local_id)
    @pago_alquiler = PagoAlquiler.new
  end

  def new_cheque_efectivo
    @mall = current_user.mall
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
            @cuenta_bancaria = CuentaBancarium.find(params[:pago_alquiler]['cuenta_bancarium_id'])
            @contrato_alquiler = ContratoAlquiler.find_by(tienda_id: @tienda_id)
            @obj = {
                :fecha_pago => params[:pago_alquiler]['fecha_pago'],
                :nro_cheque_confirmacion => params[:pago_alquiler]['nro_cheque_confirmacion'],
                :cuenta_bancarium_id => params[:pago_alquiler]['cuenta_bancarium_id'],
                :pagado => TRUE,
                :nombre_banco => params[:pago_alquiler]['nombre_banco'],
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

  def create_cheque

    @pago_alquiler = PagoAlquiler.new(pago_alquiler_params)

    @tienda_id = params[:pago_alquiler]['tienda']
    @mes_alquiler = params[:pago_alquiler]['mes_alquiler']
    @anio_alquiler = params[:pago_alquiler]['anio_alquiler']

    @pago = PagoAlquiler.where('tienda_id = ?',@tienda_id)
    if @pago.blank?
      flash[:danger] = 'La tienda no tiene recibos guardados.'
      render :action=>'new_cheque_efectivo'
    elsif
    @pago = PagoAlquiler.where('tienda_id = ? AND pagado = ?',@tienda_id, FALSE)
      if @pago.blank?
        flash[:danger] = 'La tienda no tiene recibos por pagar.'
        render :action=>'new_cheque_efectivo'
      elsif
      @pago = PagoAlquiler.where('tienda_id = ? AND pagado = ? AND anio_alquiler = ? AND mes_alquiler = ?',@tienda_id,FALSE,@anio_alquiler.to_i, @mes_alquiler.to_i)
        if @pago.blank?
          flash[:danger] = 'El mes y año a pagar no corresponde al que debe pagar.'
          render :action=>'new_cheque_efectivo'
        else
          @pago = @pago.last
          @monto_alquiler = @pago.monto_alquiler_ml

          if @monto_alquiler.to_f != params[:pago_alquiler]['monto_alquiler_ml'].to_f
            flash[:danger] = 'El monto de transferencia no corresponde al monto del canon.'
            render :action=>'new_cheque_efectivo'
          else

            @contrato_alquiler = ContratoAlquiler.find_by(tienda_id: @tienda_id)

            if params[:pago_alquiler]['tipo_pago'] == 'Cheque'
              cuenta_bancarium_id = params[:pago_alquiler]['cuenta_bancarium_id']
              @nro_cheq_conf = params[:pago_alquiler]['nro_cheque_confirmacion']
              @nombre_banco = params[:pago_alquiler]['nombre_banco']
            else
              cuenta_bancarium_id = nil
              @nro_cheq_conf = nil
              @nombre_banco = nil
            end

              @obj = {
                  :fecha_pago => params[:pago_alquiler]['fecha_pago'],
                  :nro_cheque_confirmacion => @nro_cheq_conf,
                  :cuenta_bancarium_id => cuenta_bancarium_id,
                  :pagado => TRUE,
                  :nombre_banco => @nombre_banco,
                  :facturado => FALSE,
                  :tipo_pago => params[:pago_alquiler]['tipo_pago'],
                  :contrato_alquiler_id => @contrato_alquiler.id,
              }


            @pago_alquiler = @obj

            respond_to do |format|
              if @pago.update(@pago_alquiler)
               # format.html { redirect_to pago_alquilers_url, notice: 'Pago alquiler se guardo correctamente.' }
                #format.json { head :no_content }
                format.html { redirect_to mostrar_recibo_pago_path(@pago), notice: 'Pago alquiler se guardo correctamente.' }
                format.json { render :show, status: :ok }

              else
                format.html { render action: 'new_cheque_efectivo' }
                format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
              end
            end
          end
        end
      end
    end
  end

  def pagos_mensuales

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
      params.require(:pago_alquiler).permit(:mes_alquiler,:anio_alquiler, :cuenta_bancarium_id, :monto_alquiler_ml, :fecha_pago, :nro_cheque_confirmacion, :tipo_pago, :tienda_id, :nombre_banco)
    end
end
