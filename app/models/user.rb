class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { in: 6..128 }
  validates :password, presence: true
  validates :email, presence: true
  validates :roles, presence: true

  has_many :reservations, dependent: :destroy
  has_many :vehicles, through: :reservations
end
