class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :flat, foreign_key: true
      t.references :tenant, foreign_key: {to_table: :users}
      t.text :description
      t.boolean :pending
      t.date :start_date
      t.date :end_date
      t.float :initial_rent

      t.timestamps
    end
  end
end
