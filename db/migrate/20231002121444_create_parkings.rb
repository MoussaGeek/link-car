class CreateParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :name_gerant
      t.string :city
      t.string :email

      t.timestamps
    end
  end
end
