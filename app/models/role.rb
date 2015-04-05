# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(50)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base

  has_many :users

  has_and_belongs_to_many :permissions

  validates :name, presence: true

  enum role_type: [:administrador_sistema, :administrador_cliente, :cliente_mall, :cliente_sistema]

  def self.all_valids
    Role.where.not(id: 1)
  end

  def name_type
    self.name + ' - ' + self.role_type_humanized
  end

  def role_type_humanized
    self.role_type.humanize.titleize
  end

  def self.valid_role_types
    %w[administrador_cliente cliente_mall cliente_sistema]
  end

end
