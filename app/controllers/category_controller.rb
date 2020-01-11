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
    puts params[:next_category_id].inspect
    if params[:next_category_id].blank?
      category.update_position!(Category.all.map { |c| c.position}.max + 1)
    else
      next_category = Category.find(params[:next_category_id])
      category.update_position!(next_category.position)
    end
  end

  def dropdown
     render partial: "category/dropdown", locals: { categories: Category.all }
  end
end

