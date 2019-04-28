class Setting < ApplicationRecord
  def self.voice
    Setting.where(name: 'voice').first.try(:value) || 'Oliver'
  end

  def self.password
    Setting.where(name: 'password').first.try(:value) || begin
      raise 'password not found'
    end
  end
end
