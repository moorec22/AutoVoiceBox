class CategoryController < ApplicationController
  def create
    name = params[:name]
    category = Category.create(name: name)
    render json: category
  end

  def destroy
    category = Category.find(params[:category_id])
    category.destroy!
    render partial: "category/list", locals: { categories: Category.all, current_category_id: SettingController.new.get_current_category_id }
  end

  def update
    category = Category.find(params[:category_id])
    category.update_column!(params[:column].to_i)
    if params[:next_cateory_id].nil?
      category.update_position!(Category.by_column(category.column).size)
    else
      next_category = Category.find(params[:next_category_id])
      category.update_position!(next_category.position - 1)
    end
  end
end

