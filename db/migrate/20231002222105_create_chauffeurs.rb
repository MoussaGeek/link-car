class CreateChauffeurs < ActiveRecord::Migration[6.0]
  def change
    create_table :chauffeurs do |t|
      t.string :name
      t.string :quartier
      t.references :parking, null: false, foreign_key: true
      t.integer :telephone

      t.timestamps
    end
    add_index :chauffeurs, :telephone, unique: true
  end
end
