class AddRentalToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :rental, foreign_key: true
  end
end
