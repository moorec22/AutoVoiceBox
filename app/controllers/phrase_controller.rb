class PhraseController < ApplicationController
  def index
    @categories = Category.all
  end

  def create
    category_id = params[:category_id]
    category = category_id ? Category.find(category_id) : nil
    Phrase.create(text: params[:phrase], category: category)
  end

  def destroy
    phrase = Phrase.find(params[:phrase_id])
    phrase.destroy!
  end

  def update
    phrase = Phrase.find(params[:phrase_id])
    case params[:type]
    when 'CATEGORY'
      phrase.update!(category: Category.find(params[:category_id]))
    end
  end
end

