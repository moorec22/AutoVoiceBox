class PhraseController < ApplicationController
  def create
    category_id = params[:category_id]
    category = category_id ? Category.find(category_id) : nil
    phrase = Phrase.create!(text: params[:phrase], category: category)
    render partial: 'phrase', locals: { phrase: phrase }
  end

  def destroy
    phrase = Phrase.find(params[:phrase_id])
    phrase.destroy!
  end

  def update
    phrase = Phrase.find(params[:phrase_id])
    case params[:type]
    when 'CATEGORY'
      category = Category.find(params[:category_id])
      phrase_category = PhraseCategory.new(
        phrase_id: phrase.id,
        category_id: category.id,
        position: category.next_pos
      )
      category.phrase_categories << phrase_category 
    end
  end
end

