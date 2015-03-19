class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :session_limitable
  devise :database_authenticatable,:authentication_keys => [:username]
end
