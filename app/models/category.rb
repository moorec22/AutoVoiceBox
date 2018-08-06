class Category < ApplicationRecord
  has_many :phrase_categories, dependent: :destroy

  def ordered_phrases
    phrase_categories.sort_by { |pc| pc.position }.map { |pc| pc.phrase }
  end

  def next_pos
    ordered_phrases.size
  end
end

