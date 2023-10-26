class CreateRentalHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :rental_histories do |t|
      t.string :name
      t.datetime :date
      t.time :time
      t.decimal :price
      t.integer :duration
      t.string :destination
      t.string :car_matricule
      t.string :chauffeur
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
