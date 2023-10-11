class Car < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy
  has_one_attached :photo

  validates :numero_matricule, presence: { message: "Le numéro de matricule est obligatoire." }
  validates :numero_matricule, uniqueness: { message: "Ce numéro de matricule est déjà utilisé." }

  validates :marque, :price_rental, :modele, :carburant, :car_type, length: { maximum: 250 }
end
