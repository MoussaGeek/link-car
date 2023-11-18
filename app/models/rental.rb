class Rental < ApplicationRecord
  after_create :log_rental
  belongs_to :user
  belongs_to :car
  belongs_to :chauffeur, optional: true

  validates :date, presence: true
  validates :time, presence: true
  validates :duration, presence: true
  validates :destination, presence: true
  validate :date_in_future

  validate :chauffeur_not_currently_reserved

  scope :active, -> { where("date + time + duration * interval '1 day' > ?", Time.zone.now) }

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

  private

  def date_in_future
    return if date.blank? || time.blank?

    reservation_datetime = date.to_datetime + time.seconds_since_midnight.seconds

    errors.add(:base, "La date et l'heure de location ne peuvent pas être antérieures à la date et l'heure actuelles.") if reservation_datetime < Time.current
  end

  def chauffeur_not_currently_reserved
    if chauffeur.present? && chauffeur.has_active_reservation?
      errors.add(:chauffeur, "est déjà réservé pour une autre location à cette période. Veuillez choisir un autre chauffeur ou ajuster les dates.")
    end
  end

end