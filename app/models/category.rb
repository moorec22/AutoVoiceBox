class Category < ApplicationRecord
  has_many :phrase_categories, dependent: :destroy
  has_many :category_positions, dependent: :destroy

  def self.all_ordered_by_position
    return Category.all.sort_by(&:position)
  end

  def self.by_column(column)
    Category.all.select { |category| category.column == column }
  end

  def ordered_phrases
    phrase_categories.sort_by { |pc| pc.position }.map { |pc| pc.phrase }
  end

  def next_pos
    ordered_phrases.size
  end

  def column
    category_positions.first.try(:column) || 0
  end
  
  def position
    category_positions.first.try(:position) || Category.all.size
  end

  def update_column!(column)
    if category_positions.empty?
      category_positions <<
        CategoryPosition.create!(
          category_id: id,
          position: position,
          column: column
        )
    else
      category_positions.first.update!(column: column)
    end
  end

  def update_position!(position)
    if category_positions.empty?
      category_positions <<
        CategoryPosition.create!(
          category_id: id,
          position: position,
          column: column
        )
    else
      category_positions.first.update!(position: position)
    end
    ahead = Category.all.select do |category|
      category.column == column && category.position >= position
    end
    ahead.each { |category| category.update!(position: category.position + 1) }
  end
end

