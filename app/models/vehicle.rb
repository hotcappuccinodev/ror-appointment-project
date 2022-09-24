class Vehicle < ApplicationRecord
  validates :brand, :model, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
end
