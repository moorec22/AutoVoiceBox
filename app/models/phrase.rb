class Phrase < ApplicationRecord
  # belongs_to :category, optional: true
  has_many :phrase_categories, dependent: :destroy

  def self.no_categories
    phrases = Phrase.all.select { |p| p.phrase_categories.empty? }
  end

  def say
    SystemVoice::say(text)
  end
end

