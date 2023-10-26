class RentalHistory < ApplicationRecord
  belongs_to :user

  validates :name, :date, :time, :price, :duration, :destination, :car_matricule, presence: true
end
