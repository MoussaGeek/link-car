class RentalHistory < ApplicationRecord
  belongs_to :user

  def format_date
    date.strftime("%m/%d/%Y")
  end

  def format_time
      time.strftime('%H:%M')
  end

  validates :name, :date, :time, :price, :duration, :destination, :car_matricule, presence: true
end
