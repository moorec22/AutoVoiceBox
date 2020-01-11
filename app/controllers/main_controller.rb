class MainController < ApplicationController
  def index
    fix_category_ordering
    @categories = Category.all_ordered_by_position
    @current_category = Category.count == 0 ? nil :
      Category.find(SettingController.new.get_current_category_id)
    @fixed_category = Category.count == 0 ? nil :
      Category.find(SettingController.new.get_fixed_category_id)
    @phrases_without_category = Phrase.no_categories
    @phrases_without_category = Phrase.no_categories
    @voices = SettingController.new.get_voices
    @voice = Setting.voice
  end

  private
  
  def fix_category_ordering
    Category.all_ordered_by_position.each_with_index do |category, index|
      category.set_position!(index)
    end
  end
end

