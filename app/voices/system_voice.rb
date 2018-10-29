class SystemVoice < Voice
  # TODO: Sanitize `phrase` you lazy piece of garbage!
  def self.say(phrase, voice = 'Oliver')
    system("say -v #{voice} $'#{phrase.gsub("'", "\\\\'")}'")
  end
end

