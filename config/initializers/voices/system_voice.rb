class SystemVoice < Voice
  # TODO: Sanitize `phrase` you lazy piece of garbage!
  def say(phrase)
    system( "say '#{phrase}'" )
  end
end

