class Role < ActiveRecord::Base

  has_many :users

  has_and_belongs_to_many :permissions

  validates :name, presence: true

  def self.all_valids
    Role.where.not(id: 1)
  end
end
