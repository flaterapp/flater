class CreateDossiers < ActiveRecord::Migration[5.2]
  def change
    create_table :dossiers do |t|
      t.references :rental, foreign_key: true
      t.references :candidate, foreign_key: {to_table: :users}
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.string :tax_proof
      t.float :monthly_revenues
      t.string :revenues_proof
      t.string :activity
      t.string :activity_proof
      t.string :identity_proof

      t.timestamps
    end
  end
end
