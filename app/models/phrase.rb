class Phrase < ApplicationRecord
  belongs_to :category
  def say
    SystemVoice::say(text)
  end
end
