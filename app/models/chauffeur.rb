# app/models/chauffeur.rb
class Chauffeur < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy

  has_one_attached :photo_permis
  has_one_attached :photo_carte

  validates :name, :quartier, presence: true
  validates :telephone, presence: true, format: { with: /\A\d{8}\z/, message: "doit contenir exactement huit chiffres" }
  validates :name, :quartier, length: { maximum: 250 }

  def is_available?
    !has_active_reservation?
  end

  def has_active_reservation?
    Rental.where(chauffeur_id: id).active.exists?
  end

end