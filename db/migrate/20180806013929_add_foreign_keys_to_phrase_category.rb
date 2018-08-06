class AddForeignKeysToPhraseCategory < ActiveRecord::Migration[5.0]
  def change
    remove_column :phrase_categories, :phrase_id
    remove_column :phrase_categories, :category_id

    add_foreign_key :phrase_categories, :phrases
    add_foreign_key :phrase_categories, :categories
  end
end
