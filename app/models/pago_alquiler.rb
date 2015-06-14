# == Schema Information
#
# Table name: pago_alquilers
#
#  id :integer  not null, primary key
# nroRecibo :string
# fechaReciboCobro :date
# anioAlquiler :int
# mesAlquiler :int
# montoCanonFijoML :decimal
# montoPorcVentasML :decimal
# montoAlquilerML :decimal
# montoAlquilerUSD :decimal
# pagado :bool
# - fechaPago :date
# - nroChequeConfirmacion :string
# - archivoTransferencia :string
# - nombreBanco :string
# - facturado :bool
# - nroFactura :string
# - fechaFactura :date


class PagoAlquiler < ActiveRecord::Base
  belongs_to :cuenta_bancarium
  has_many :detalle_pago_alquilers

  enum tipo_pago: [:Cheque, :Transferencia, :Efectivo]

  def self.valid_forma_pago
    %w[Cheque Efectivo]
  end
end
