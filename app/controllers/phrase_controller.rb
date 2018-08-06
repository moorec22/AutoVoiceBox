class PhraseController < ApplicationController
  def create
    category_id = params[:category_id]
    phrase = Phrase.create!(text: params[:phrase])
    render partial: 'phrase', locals: { phrase: phrase }
  end

  def destroy
    PhraseCategory.where(phrase_id: params[:phrase_id]).each { |pc| pc.destroy! }
    phrase = Phrase.find(params[:phrase_id])
    phrase.destroy!
  end

  def update
    phrase = Phrase.find(params[:phrase_id])
    case params[:type]
    when 'CATEGORY'
      # TODO: In a multi-category model, this must be rethunk!
      category = Category.find(params[:category_id])
      phrase.phrase_categories.each { |pc| pc.destroy! }
      new_phrase_category = PhraseCategory.new(
        phrase_id: phrase.id,
        category_id: category.id,
        position: category.next_pos
      )
      category.phrase_categories << new_phrase_category 
    end
  end
end

