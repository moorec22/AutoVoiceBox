class AddCategoryToPhrase < ActiveRecord::Migration[5.0]
  def change
    add_column :phrases, :category_id, :integer, foreign_key: true
  end
end
