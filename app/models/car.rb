class Car < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy
  has_one_attached :photo

  validates :marque, presence: true
  validates :price_rental, presence: true
  validates :modele, presence: true
  validates :annee, presence: true
  validates :carburant, presence: true
  validates :car_type, presence: true
  validates :numero_matricule, presence: true
end
