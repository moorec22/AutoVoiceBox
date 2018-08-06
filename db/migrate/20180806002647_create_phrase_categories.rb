class CreatePhraseCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :phrase_categories do |t|
      t.integer :phrase_id
      t.integer :category_id
      t.integer :position

      t.timestamps
    end
  end
end
