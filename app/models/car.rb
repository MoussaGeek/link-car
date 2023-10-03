class Car < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy

  has_one_attached :photo
end
