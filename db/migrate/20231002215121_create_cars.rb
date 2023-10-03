class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :numero_matricule
      t.string :marque
      t.string :modele
      t.string :car_type
      t.integer :annee
      t.integer :price_rental
      t.string :carburant
      t.boolean :disponible, default: true
      t.references :parking, null: false, foreign_key: true

      t.timestamps
    end
    add_index :cars, :numero_matricule, unique: true
  end
end
