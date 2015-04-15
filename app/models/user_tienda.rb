# == Schema Information
#
# Table name: user_tiendas
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tienda_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserTienda < ActiveRecord::Base
  belongs_to :user
  belongs_to :tienda
end
