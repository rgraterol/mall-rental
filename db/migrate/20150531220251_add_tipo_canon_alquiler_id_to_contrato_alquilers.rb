class AddTipoCanonAlquilerIdToContratoAlquilers < ActiveRecord::Migration
  def change
    add_column :contrato_alquilers, :tipo_canon_alquiler_id, :integer
  end
end
