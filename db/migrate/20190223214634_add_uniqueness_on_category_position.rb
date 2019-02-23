class AddUniquenessOnCategoryPosition < ActiveRecord::Migration[5.0]
  def change
    add_index :category_positions, :category_id, unique: true
  end
end
