class SpeechController < ApplicationController
  def create
    SystemVoice::say(params[:phrase])
  end
end
