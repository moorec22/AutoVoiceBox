class SettingController < ApplicationController
  VOICES = [
    'Daniel',
    'Oliver',
    'Peter',
    'Samantha',
    'Victoria',
    'Alex',
    'Fred',
  ].freeze

  def get_voices
    VOICES
  end

  def get_voice
    Setting.voice
  end

  def update_voice
    voice = params[:voice]
    Setting.find_or_create_by(name: 'voice').update(value: voice)
  end
end

