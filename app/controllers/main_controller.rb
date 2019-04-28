class MainController < ApplicationController
  http_basic_authenticate_with name: "forrest", password: Setting.password

  def index
    @categories = Category.all_ordered_by_position
    @phrases_without_category = Phrase.no_categories
    @voices = SettingController.new.get_voices
    @voice = Setting.voice
  end
end

