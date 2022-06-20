class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    unless params[:target_day]
      @categories = current_user.categories.order(target_date: :desc)
    else 
      @categories = current_user.categories.where('target_date = ?', params[:target_day])
      @target_day = params[:target_day]
    end
  end

  def show
  end
  
  def new
    @category = Category.new
    @target_day = params[:target_day]
  end  

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to calendar_path, notice: 'Category is successfully created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to params[:previous_request]
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    if current_user.categories.where('target_date = ?', params[:target_day]).exists?
      redirect_to categories_path(target_day: params[:target_day])
    else
      redirect_to calendar_path
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :details, :target_date, :user_id, :previous_request)
  end
end
