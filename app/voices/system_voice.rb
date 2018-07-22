class SystemVoice < Voice
  # TODO: Sanitize `phrase` you lazy piece of garbage!
  def self.say(phrase)
    system("say -v Oliver $'#{phrase.gsub("'", "\\\\'")}'")
  end
end

