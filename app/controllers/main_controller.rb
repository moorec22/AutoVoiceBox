class MainController < ApplicationController
  def index
    @categories = Category.all
    @phrases_without_category = Phrase.no_categories
  end
end

