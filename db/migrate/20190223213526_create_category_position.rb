class CreateCategoryPosition < ActiveRecord::Migration[5.0]
  def change
    create_table :category_positions do |t|
      t.integer :position
      t.integer :category_id
    end
    add_foreign_key :category_positions, :categories
  end
end
