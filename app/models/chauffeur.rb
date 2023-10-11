class Chauffeur < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy

  validates :telephone, presence: true, format: { with: /\A\d{8}\z/, message: "doit contenir exactement huit chiffres" }
  validates :name, :quartier, length: {maximum: 250}
end
