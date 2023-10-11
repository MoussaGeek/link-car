class Parking < ApplicationRecord
    validates :name, :name_gerant, :email, :city, presence: true
    validates :name, :name_gerant, :email, :city, length: {maximum: 250}
    validates :latitude, presence: true
    validates :longitude, presence: true

    has_many :chauffeurs, dependent: :destroy
    has_many :cars, dependent: :destroy
end
