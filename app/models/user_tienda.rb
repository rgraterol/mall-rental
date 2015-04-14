class UserTienda < ActiveRecord::Base
  belongs_to :user
  belongs_to :tienda
end
