class MainController < ApplicationController
  def index
    @categories = Category.all
    @phrases_without_category = Phrase.where(category: nil)
  end
end

