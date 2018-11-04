require 'thread'

class SpeechController < ApplicationController
  @@lock = Mutex.new

  def create
    if @@lock.try_lock
      SystemVoice::say(params[:phrase], Setting.voice)
      @@lock.unlock
    end
  end
end
