class Reservation < ApplicationRecord
  validates :user_id, presence: true
  validates :vehicle_id, presence: true
  validates :date, presence: true
  validates :city, presence: true

  belongs_to :user
  belongs_to :vehicle
end
