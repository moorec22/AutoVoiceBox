class Setting < ApplicationRecord
  def self.voice
    Setting.where(name: 'voice').first.try(:value) || 'Oliver'
  end
end
