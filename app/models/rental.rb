class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :destination, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :duration, presence: true
end
