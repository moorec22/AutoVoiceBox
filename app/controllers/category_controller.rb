class CategoryController < ApplicationController
  def create
    name = params[:name]
    category = Category.create(name: name)
    render partial: "phrase/category", locals: { category: category }
  end

  def destroy
    category = Category.find(params[:category_id])
    category.destroy!
  end
end

