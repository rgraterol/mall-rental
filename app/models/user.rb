class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :session_limitable
  devise :database_authenticatable,:authentication_keys => [:username]

  validates :username, presence: {message: 'es obligatorio'},
            uniqueness: {message: 'ya en uso.'}
end
