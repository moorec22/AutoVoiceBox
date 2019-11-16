class PhraseCategory < ApplicationRecord
  belongs_to :phrase, dependent: :destroy
  belongs_to :category
end

