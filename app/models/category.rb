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

  def update_position!(new_position)
    set_position!(new_position)
    ahead = Category.all.select do |category|
      category.position >= new_position && category.id != self.id
    end
    distance = 1
    ahead.each do |category|
      category.set_position!(category.position + distance)
      distance += 1
    end
    Category.all.each do |c|
      puts c.name, c.position
    end
  end

  # set position without updating the work ahead
  def set_position!(new_position)
    if category_positions.empty?
      category_positions <<
        CategoryPosition.create!(
          category_id: id,
          position: new_position,
        )
    else
      category_positions.first.update!(position: new_position)
    end

  end
end

