class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :chauffeur, optional: true
end
