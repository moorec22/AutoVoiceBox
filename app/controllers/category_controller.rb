class CategoryController < ApplicationController
  def create
    name = params[:name]
    Category.create(name: name)
  end

  def destroy
    category = Category.find(params[:category_id])
    category.destroy!
  end
end

