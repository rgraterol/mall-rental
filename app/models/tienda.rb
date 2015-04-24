# == Schema Information
#
# Table name: tiendas
#
#  id                        :integer          not null, primary key
#  nombre                    :string(255)
#  fecha_apertura            :date
#  fecha_cierre              :date
#  abierta                   :boolean
#  fecha_fin_contrato_actual :date
#  local_id                  :integer
#  actividad_economica_id    :integer
#  arrendatario_id           :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class Tienda < ActiveRecord::Base
  belongs_to :local
  has_one :nivel_mall, through: :local
  has_one :tipo_local, through: :local
  belongs_to :actividad_economica
  belongs_to :arrendatario
  has_one :mall, through: :arrendatario

  has_many :contrato_alquilers, dependent: :destroy
  accepts_nested_attributes_for :contrato_alquilers, allow_destroy: true, reject_if: :all_blank

  has_many :ventas, dependent: :destroy
  has_many :user_tiendas, dependent: :destroy
  has_many :users, through: :user_tiendas
  has_many :pago_alquilers

  after_create :set_missing_attributes
  # after_update :set_missing_attributes

  validates :local_id, :actividad_economica_id, :arrendatario_id, presence: true

  def set_missing_attributes
<<<<<<< HEAD
    self.update(fecha_apertura: (self.contrato_alquilers.first.fecha_inicio rescue Date.today),
                abierta: true, fecha_fin_contrato_actual: (self.contrato_alquilers.last.fecha_inicio rescue Date.today))
=======
    self.update(fecha_apertura: '2015-01-01',
                abierta: true, fecha_fin_contrato_actual: '2015-12-30')
>>>>>>> 7ca418d2c4173f77298279060393bd267e5c918b
  end

  def vencido?
    if self.contrato_alquilers.last.fecha_fin < Date.today
      return 'Si'
    else
      return 'No'
    end
  end

  def self.by_nivel_mall(nivel_mall_id)
    return where(nil) unless nivel_mall_id.present?
    where(nivel_malls: {id: nivel_mall_id})
  end

  def self.by_actividad_economica(actividad_economica_id)
    return where(nil) unless actividad_economica_id.present?
    where(actividad_economicas: {id: actividad_economica_id})
  end

  def self.by_vencimiento(vencido)
    return where(nil) unless vencido.present?
    if vencido == 'vencidos'
      return where("contrato_alquilers.fecha_fin < ?", Date.today)
    elsif vencido == 'vigentes'
      return where("contrato_alquilers.fecha_fin >= ?", Date.today)
    else
      where(nil)
    end
  end

  def self.by_rango_contrato(fecha_init, fecha_end)
    return where(nil) unless fecha_init.present? || fecha_end.present?
    where("contrato_alquilers.fecha_fin >= ? AND contrato_alquilers.fecha_inicio <= ?", fecha_end, fecha_init)
  end

  def self.by_tipo_local(tipo_local_id)
    return where(nil) unless tipo_local_id.present?
    where(tipo_locals: {id: tipo_local_id})
  end


  #TODO MOVER A UN LUGAR MAS ADECUADO
  def self.estadisticas(mall, fecha_init, fecha_end, nivel_mall_id, actividad_economica_id, tipo_local_id, criterio )
    estadisticas = Array.new
    if criterio == 'tiendas'
      mall.tiendas.joins(:nivel_mall, :actividad_economica, :tipo_local, :contrato_alquilers).by_nivel_mall(nivel_mall_id).by_actividad_economica(actividad_economica_id).by_rango_contrato(fecha_init, fecha_end).by_tipo_local(tipo_local_id).each do |tienda|
        hash_stats = Hash.new
        canon_fijo = 0
        canon_fijo_usd = 0
        porc_canon = 0
        ventas = 0
        tienda.contrato_alquilers.each do |contrato|
          canon_fijo, canon_fijo_usd, porc_canon, ventas = ventas_x_contrato(canon_fijo, canon_fijo_usd, contrato, porc_canon, ventas)
        end
        hash_stats[:ventas] = ventas
        hash_stats[:canon_fijo_ml] = canon_fijo
        hash_stats[:canon_fijo_usd] = canon_fijo_usd
        hash_stats[:porc_canon] = porc_canon
        hash_stats[:criterio] = tienda.nombre
        estadisticas << hash_stats
      end
    elsif criterio == 'nivel_mall'
      mall.nivel_mall_stats(nivel_mall_id).each do |nivel_mall|
        canon_fijo = 0
        canon_fijo_usd = 0
        porc_canon = 0
        ventas = 0
        nivel_mall.tiendas.joins(:nivel_mall, :actividad_economica, :tipo_local, :contrato_alquilers).by_nivel_mall(nivel_mall_id).by_actividad_economica(actividad_economica_id).by_rango_contrato(fecha_init, fecha_end).by_tipo_local(tipo_local_id).each do |tienda|
          ventas += ventas
          canon_fijo += canon_fijo
          canon_fijo_usd += canon_fijo_usd
          porc_canon += porc_canon
          tienda.contrato_alquilers.each do |contrato|
            canon_fijo, canon_fijo_usd, porc_canon, ventas = ventas_x_contrato(canon_fijo, canon_fijo_usd, contrato, porc_canon, ventas)
          end
        end
        hash_stats = Hash.new
        hash_stats[:canon_fijo_ml] = canon_fijo
        hash_stats[:canon_fijo_usd] = canon_fijo_usd
        hash_stats[:porc_canon] = porc_canon
        hash_stats[:criterio] = nivel_mall.nombre
	hash_stats[:ventas] = ventas
        estadisticas << hash_stats
      end
    elsif criterio == 'actividad_economica'
      mall.actividad_economicas_stats(actividad_economica_id).each do |actividad_economica|
        canon_fijo = 0
        canon_fijo_usd = 0
        porc_canon = 0
        ventas = 0
        actividad_economica.tiendas.joins(:nivel_mall, :actividad_economica, :tipo_local, :contrato_alquilers).by_nivel_mall(nivel_mall_id).by_actividad_economica(actividad_economica_id).by_rango_contrato(fecha_init, fecha_end).by_tipo_local(tipo_local_id).each do |tienda|
          ventas += ventas
          canon_fijo += canon_fijo
          canon_fijo_usd += canon_fijo_usd
          porc_canon += porc_canon
          tienda.contrato_alquilers.each do |contrato|
            canon_fijo, canon_fijo_usd, porc_canon, ventas = ventas_x_contrato(canon_fijo, canon_fijo_usd, contrato, porc_canon, ventas)
          end
        end
        hash_stats = Hash.new
        hash_stats[:canon_fijo_ml] = canon_fijo
        hash_stats[:canon_fijo_usd] = canon_fijo_usd
        hash_stats[:porc_canon] = porc_canon
	hash_stats[:ventas] = ventas
        hash_stats[:criterio] = actividad_economica.nombre
        estadisticas << hash_stats
      end
    elsif criterio == 'tipo_local'
      mall.tipo_locals_stats(tipo_local_id).each do |tipo_local|
        canon_fijo = 0
        canon_fijo_usd = 0
        porc_canon = 0
        ventas = 0
        tipo_local.tiendas.joins(:nivel_mall, :actividad_economica, :tipo_local, :contrato_alquilers).by_nivel_mall(nivel_mall_id).by_actividad_economica(actividad_economica_id).by_rango_contrato(fecha_init, fecha_end).by_tipo_local(tipo_local_id).each do |tienda|
          ventas += ventas
          canon_fijo += canon_fijo
          canon_fijo_usd += canon_fijo_usd
          porc_canon += porc_canon
          tienda.contrato_alquilers.each do |contrato|
            canon_fijo, canon_fijo_usd, porc_canon, ventas = ventas_x_contrato(canon_fijo, canon_fijo_usd, contrato, porc_canon, ventas)
          end
        end
        hash_stats = Hash.new
        hash_stats[:canon_fijo_ml] = canon_fijo
        hash_stats[:canon_fijo_usd] = canon_fijo_usd
        hash_stats[:porc_canon] = porc_canon
        hash_stats[:criterio] = tipo_local.tipo
	hash_stats[:ventas] = ventas
        estadisticas << hash_stats
      end
    end
    return estadisticas
  end

  def self.ventas_x_contrato(canon_fijo, canon_fijo_usd, contrato, porc_canon, ventas)
    ventas += ventas
    canon_fijo += canon_fijo
    canon_fijo_usd += canon_fijo_usd
    porc_canon += porc_canon
    ventas = contrato.ventas.count
    canon_fijo = contrato.ventas.count * contrato.canon_fijo_ml unless contrato.canon_fijo_ml.blank?
    canon_fijo_usd = contrato.ventas.count * contrato.canon_fijo_usd unless contrato.canon_fijo_ml.blank?
    porc_canon = contrato.ventas.sum(:monto_ml) * contrato.porc_canon_ventas unless contrato.porc_canon_ventas.blank?
    return canon_fijo, canon_fijo_usd, porc_canon, ventas
  end


end
