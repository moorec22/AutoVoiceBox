class RemoveCategoryFromPhrase < ActiveRecord::Migration[5.0]
  def change
    remove_column :phrases, :category_id
  end
end
