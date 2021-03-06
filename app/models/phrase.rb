class Phrase < ApplicationRecord
  # belongs_to :category, optional: true
  has_many :phrase_categories, dependent: :destroy

  def self.no_categories
    phrases = Phrase.all.select { |p| p.phrase_categories.empty? }
  end

  def position(category)
    # TODO: Create uniqueness constraint on (phrase_id, category_id) in
    # phrase_categories
    phrase_categories.where(category_id: category.id).first.position
  end

  def say
    SystemVoice::say(text)
  end
end

