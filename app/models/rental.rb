class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :chauffeur, optional: true

  validates :date, :time, :duration, :destination, presence: true
  validates :duration, :destination, length: {maximum: 250}

  def format_date
    date.strftime("%m/%d/%Y")
  end

  def format_time
      time.strftime('%H:%M')
  end
  
  def appointment_time
      (time - 1800).strftime('%H:%M')
  end

end
