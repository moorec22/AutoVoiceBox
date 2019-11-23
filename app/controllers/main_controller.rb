class MainController < ApplicationController
  def index
    @categories = Category.all_ordered_by_position
    @current_category = Category.count == 0 ? nil :
      Category.find(SettingController.new.get_current_category_id)
    @phrases_without_category = Phrase.no_categories
    @voices = SettingController.new.get_voices
    @voice = Setting.voice
  end
end

