class SpeechController < ApplicationController
  def create
    SystemVoice::say(params[:phrase], Setting.voice)
  end
end
