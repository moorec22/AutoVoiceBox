class SystemVoice < Voice
  # TODO: Sanitize `phrase` you lazy piece of garbage!
  def self.say(phrase)
    puts phrase.gsub("'", "\\\\'")
    system("say -v Oliver $'#{phrase.gsub("'", "\\\\'")}'")
  end
end

