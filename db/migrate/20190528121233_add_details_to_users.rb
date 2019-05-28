class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :birthdate, :date
    add_column :users, :sex, :string
  end
end
