class AddComplementaryInfoToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :complementary_info, :string
  end
end
