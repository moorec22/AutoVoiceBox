class Phrase < ApplicationRecord
  belongs_to :category, optional: true

  def say
    SystemVoice::say(text)
  end
end
