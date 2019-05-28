class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :address
      t.references :owner, foreign_key: {to_table: :users}
      t.boolean :to_rent
      t.string :type
      t.float :surface
      t.integer :nb_rooms
      t.boolean :furnished
      t.text :description

      t.timestamps
    end
  end
end