class AddMallRefToCalendarioNoLaborable < ActiveRecord::Migration
  def change
    add_reference :calendario_no_laborables, :mall, index: true
  end
end
