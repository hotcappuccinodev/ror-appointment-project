class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :password, presence: true
  validates :email, presence: true
  validates :roles, presence: true

  has_many :reservations, dependent: :destroy
  has_many :vechiles, through: :group_entities
end
