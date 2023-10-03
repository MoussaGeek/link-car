class Parking < ApplicationRecord
    validates :name, :name_gerant, :email, :city, presence: true
    validates :name, :name_gerant, :email, :city, length: {maximum: 250}

    has_many :chauffeurs
    has_many :cars, dependent: :destroy
end
