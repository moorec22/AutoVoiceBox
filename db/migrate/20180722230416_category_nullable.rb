class CategoryNullable < ActiveRecord::Migration[5.0]
  def change
    change_column_null :phrases, :category_id, true 
  end
end
