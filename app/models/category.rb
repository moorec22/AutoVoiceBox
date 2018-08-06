class Category < ApplicationRecord
  has_many :phrase_categories

  def ordered_phrases
    phrase_categories.sort_by { |pc| pc.position }.map { |pc| pc.phrase }
  end
end

