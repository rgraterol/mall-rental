class Permission < ActiveRecord::Base

  has_and_belongs_to_many :roles

  def name_action_class
    "Nombre: "+ self.name + " - Accion: " + self.action + " -  Controlador: " + (self.subject_class || "")
  end
end
