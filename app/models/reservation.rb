class Reservation < ApplicationRecord
  validates :user_id, presence: true
  validates :vehicle_id, presence: true
  validates :date, presence: true
  validates :city, presence: true

  belongs_to :users, class_name: 'User', foreign_key: 'user_id'
  belongs_to :vehicles, class_name: 'vehicle', foreign_key: 'vehicle_id'
end
