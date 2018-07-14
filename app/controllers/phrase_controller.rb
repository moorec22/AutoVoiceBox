class PhraseController < ApplicationController
  def index
    Phrase.all.each do |phrase|
      puts phrase.text
    end
    @phrases = Phrase.all
  end

  def create
    phrase = Phrase.new(text: params[:phrase])
    phrase.save!
  end
end
