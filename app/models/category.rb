class Category < ApplicationRecord
  has_many :phrase_categories, dependent: :destroy
  has_many :category_positions, dependent: :destroy

  def self.all_ordered_by_position
    return Category.all.sort_by(&:position)
  end

  def ordered_phrases
    phrase_categories.sort_by { |pc| pc.position }.map { |pc| pc.phrase }
  end

  def next_pos
    ordered_phrases.size
  end
  
  def position
    category_positions.first.try(:position) || Category.all.size
  end
end

