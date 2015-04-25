class EstadisticasController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :estadisticas

  def mf_intermensuales_vxa
    @estadisticas = Hash.new
    @estadisticas[:canon_fijo] = Array.new
    @estadisticas[:porc_ventas] = Array.new
    current_user.mall.tiendas.each do |tienda|
      tienda.contrato_alquilers.each do |contrato|
        @estadisticas[:porc_ventas] << contrato.ventas.sum(:monto_ml) * contrato.porc_canon_ventas if contrato.porc_canon_ventas.present?
        @estadisticas[:canon_fijo] << contrato.ventas.count * contrato.canon_fijo_ml if contrato.canon_fijo_ml.present?
      end
    end
  end

  def filtro_intermensuales

    @estadisticas = Tienda.estadisticas(current_user.mall, params[:fecha_init], params[:fecha_end], params[:nivel_mall_id], params[:actividad_economica_id], params[:tipo_local_id], params[:criterio])
    render partial: 'table_intermensuales_vxa'
  end

  def mf_mensuales_vxa
  end

  def filtro_mensuales
  end


  private
    def self.permission
      'estadisticas'
    end
end
