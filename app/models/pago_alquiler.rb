# == Schema Information
#
# Table name: pago_alquilers
#
#  id                      :integer          not null, primary key
#  nro_recibo              :string(255)
#  fecha_recibo_cobro      :date
#  anio_alquiler           :integer
#  mes_alquiler            :integer
#  monto_canon_fijo_ml     :decimal(, )
#  monto_porc_ventas_ml    :decimal(, )
#  monto_alquiler_ml       :decimal(, )
#  monto_alquiler_usd      :decimal(, )
#  pagado                  :boolean
#  fecha_pago              :date
#  nro_cheque_confirmacion :string(255)
#  archivo_transferencia   :string(255)
#  nombre_banco            :string(255)
#  facturado               :boolean
#  nro_factura             :string(255)
#  fecha_factura           :date
#  tipo_pago               :integer
#  contrato_alquiler_id    :integer
#  tienda_id               :integer
#  cuenta_bancarium_id     :integer
#  created_at              :datetime
#  updated_at              :datetime
#



class PagoAlquiler < ActiveRecord::Base
  belongs_to :cuenta_bancarium
  has_many :detalle_pago_alquilers

  enum tipo_pago: [:Cheque, :Transferencia, :Efectivo]

  def self.valid_forma_pago
    %w[Cheque Efectivo]
  end
end
