class Rental < ApplicationRecord
  after_create :log_rental
  belongs_to :user
  belongs_to :car
  belongs_to :chauffeur, optional: true

  validates :date, :time, :duration, :destination, presence: true
  validates :duration, :destination, length: {maximum: 250}

  scope :active, -> { where("date + time + duration * interval '1 day' > ?", Time.current) }

  def format_date
    date.strftime("%m/%d/%Y")
  end

  def format_time
      time.strftime('%H:%M')
  end

  def log_rental
    RentalHistory.create(
      name: user.name,
      date: created_at,
      time: time,
      price: car.price_rental,
      duration: duration,
      destination: destination,
      car_matricule: car.numero_matricule,
      chauffeur: chauffeur&.name,
      user: user
    )
  end

  def expired?
    end_datetime = date.to_datetime + time.seconds_since_midnight.seconds + duration.days
    end_datetime < Time.current
  end

end
