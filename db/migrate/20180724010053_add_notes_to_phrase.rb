class AddNotesToPhrase < ActiveRecord::Migration[5.0]
  def change
    add_column :phrases, :notes, :text
  end
end
