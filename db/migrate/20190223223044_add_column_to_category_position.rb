class AddColumnToCategoryPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :category_positions, :column, :integer
  end
end
