class AddReadToDirectMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :direct_messages, :read, :boolean, default: false
  end
end
