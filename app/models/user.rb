class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_authentication_token

  validates :name, presence: true, length: { in: 6..128 }
  validates :password, presence: true
  validates :email, presence: true
  validates :roles, presence: true

  has_many :reservations, dependent: :destroy
  has_many :vehicles, through: :reservations

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  ROLES = %i[user admin].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def admin?
    is?('admin')
  end
end
