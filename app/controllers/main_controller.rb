class MainController < ApplicationController
  def index
    @categories = Category.all
    @phrases_without_category = Phrase.no_categories
    @voices = SettingController.new.get_voices
    @voice = Setting.voice
  end
end

