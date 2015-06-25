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
    @facturas_array = Array.new()
    @total_x_pagar = 0
    @cobranza_alquiler = CobranzaAlquiler.where(tienda_id: @tienda.id)
    if !@cobranza_alquiler.blank?
      @cobranza_alquiler.each do |cobranza|
        @facturas = cobranza.factura_alquilers.where("saldo_deudor > ?", 0)
        @facturas.each do |factura|
          @obj = {
              "cobranza" => cobranza,
              "factura" => factura,
              "monto_v" => ActionController::Base.helpers.number_to_currency(factura.saldo_deudor , separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              "monto" => factura.saldo_deudor,
          }
          @total_x_pagar += factura.saldo_deudor

          @facturas_array.push(@obj)
        end
      end

    end
    @pago_alquiler = PagoAlquiler.new
    @facturas = Array.new()
    @detalle_pago_alquiler = @pago_alquiler.detalle_pago_alquilers.build
    @total_x_pagar_v = ActionController::Base.helpers.number_to_currency(@total_x_pagar , separator: ',', delimiter: '.', format: "%n %u", unit: "")
  end

  def new_cheque_efectivo

    @pago_alquiler = PagoAlquiler.new
    #raise @tienda_id.inspect
    @tienda_id = params[:id]

    @facturas_array = Array.new()
    @total_x_pagar = 0
    @cobranza_alquiler = CobranzaAlquiler.where(tienda_id: @tienda_id)
    if !@cobranza_alquiler.blank?
      @cobranza_alquiler.each do |cobranza|
        @facturas = cobranza.factura_alquilers.where("saldo_deudor > ?", 0)
        @facturas.each do |factura|
          @obj = {
              "cobranza" => cobranza,
              "factura" => factura,
              "monto_v" => ActionController::Base.helpers.number_to_currency(factura.saldo_deudor , separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              "monto" => factura.saldo_deudor,
          }
          @total_x_pagar += factura.saldo_deudor

          @facturas_array.push(@obj)
        end
      end

    end
    @pago_alquiler = PagoAlquiler.new
    @facturas = Array.new()
    @detalle_pago_alquiler = @pago_alquiler.detalle_pago_alquilers.build
    @total_x_pagar_v = ActionController::Base.helpers.number_to_currency(@total_x_pagar , separator: ',', delimiter: '.', format: "%n %u", unit: "")

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
        @cant_fact = params[:pago_alquiler][:detalle_pago_alquilers_attributes].length
        for i in (0..@cant_fact-1)
          @num = i.to_s
          @monto = params[:pago_alquiler][:detalle_pago_alquilers_attributes][@num]['monto_fact']
          @factura_id = params[:pago_alquiler][:detalle_pago_alquilers_attributes][@num]['factura_alquiler_id']
          @cobranza_id = params[:pago_alquiler][:detalle_pago_alquilers_attributes][@num]['cobranza_alquiler_id']

          @pago_id = @pago_alquiler.id
          @detalle =  DetallePagoAlquiler.new(monto: @monto, pago_alquiler_id: @pago_id, factura_alquiler_id: @factura_id)
          @cobranza_alquiler = CobranzaAlquiler.find(@cobranza_id)

          @factura = FacturaAlquiler.find(@factura_id)
          @monto_abonado = @factura.monto_abono.to_f
          @monto_abono = @monto_abonado + @monto.to_f
          @monto_factura = @factura.monto_factura
          @saldo_deudor = @monto_factura - @monto_abono
          @obj = {
              :monto_abono => @monto_abono,
              :saldo_deudor => @saldo_deudor,
          }
          @fact_alquiler = @obj

          if @detalle.save
            @factura.update(@fact_alquiler)
            @cobranza_alquiler.update(saldo_deudor: @saldo_deudor)
            format.html { redirect_to pago_alquilers_path, notice: 'Pago Alquiler guardado existosamente.' }
            format.json { render :index, status: :created, location: @pago_alquiler }
          else
            format.html { render :new }
            format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
          end
        end
      else
        format.html { render :new }
        format.json { render json: @pago_alquiler.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_cheque

=begin
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
=end
  end

  def facturas_tiendas

    @tienda_id = params[:id]

    redirect_to(:controller => 'pago_alquilers', :action => 'new_cheque_efectivo', id: @tienda_id)
    @pago_alquiler = PagoAlquiler.new


    @facturas_arr = Array.new
    @total_x_pagar = 0
    @cobranza_alquiler = CobranzaAlquiler.where(tienda_id: @tienda_id)

    if !@cobranza_alquiler.blank?
      @cobranza_alquiler.each do |cobranza|
        @facturas = cobranza.factura_alquilers.where("saldo_deudor > ?", 0)


        @facturas.each do |factura|
          @entro = factura.inspect

          @obj = {
              "cobranza" => cobranza,
              "factura" => factura,
              "monto_v" => ActionController::Base.helpers.number_to_currency(factura.saldo_deudor , separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              "monto" => factura.saldo_deudor,
          }

          @total_x_pagar += factura.saldo_deudor

          @facturas_arr.push(@obj)


        end

      end

    end
=begin
      @pago_alquiler = PagoAlquiler.new
      @facturas = Array.new()
      @detalle_pago_alquiler = @pago_alquiler.detalle_pago_alquilers.build
      @total_x_pagar_v = ActionController::Base.helpers.number_to_currency(@total_x_pagar , separator: ',', delimiter: '.', format: "%n %u", unit: "")

     # render json: [factura_alquilers: @facturas_array]
=end

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
      params.require(:pago_alquiler).permit(:nro_recibo, :fecha, :monto, :monto_usd, :nro_cheque_confirmacion, :banco_emisor, :tipo_pago, :cuenta_bancaria_id, detalle_pago_alquilers_params: [:factura_alquiler_id, :monto, :pago_alquiler_id] )
    end
end
