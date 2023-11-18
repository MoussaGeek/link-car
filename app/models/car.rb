class Car < ApplicationRecord
  belongs_to :parking
  has_many :rentals, dependent: :destroy
  has_one_attached :photo

  def update_status_after_numero_matricule_change(new_numero_matricule)
    if numero_matricule_changed?
      rentals.destroy_all
      update(disponible: true)
    end
  end


  validates :marque, presence: true
  validates :price_rental, presence: true
  validates :modele, presence: true
  validates :annee, presence: true
  validates :numero_matricule, presence: true, uniqueness: { message: "Ce numéro matricule est déjà pris. Veuillez en choisir un autre." }
  validates :car_type, presence: true
  validates :numero_matricule, presence: true
end
