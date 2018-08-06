class PhraseCategory < ApplicationRecord
  belongs_to :phrase
  belongs_to :category
end

