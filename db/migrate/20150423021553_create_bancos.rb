class CreateBancos < ActiveRecord::Migration
  def change
    create_table :bancos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
