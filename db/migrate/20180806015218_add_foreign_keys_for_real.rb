class AddForeignKeysForReal < ActiveRecord::Migration[5.0]
  def change
    add_column :phrase_categories, :phrase_id, :integer
    add_column :phrase_categories, :category_id, :integer

    add_foreign_key :phrase_categories, :phrases
    add_foreign_key :phrase_categories, :categories
  end
end
