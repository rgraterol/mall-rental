# == Schema Information
#
# Table name: calendario_no_laborables
#
#  id         :integer          not null, primary key
#  fecha      :date
#  motivo     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CalendarioNoLaborable < ActiveRecord::Base
  validates :motivo, presence: true
  validates :fecha, presence: true, uniqueness: true
end
