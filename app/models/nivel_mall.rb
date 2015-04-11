class NivelMall < ActiveRecord::Base
  belongs_to :mall
  has_many :locals
end
