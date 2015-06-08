class DocumentoVenta < ActiveRecord::Base
  belongs_to :venta_mensual

  validates :venta_mensual, presence: true
end
