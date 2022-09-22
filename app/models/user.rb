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
  has_many :vehicle, through: :reservations

  ROLES = %i[user admin].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def admin?
    is?('admin')
  end

end
