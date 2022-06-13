class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_target_day, only: [:new, :edit]

  def index
    unless params[:target_day]
      @categories = Category.where(user_id: current_user.id).order(:target_date)
    else 
      @categories = Category.where(user_id: current_user.id).where('target_date = ?', params[:target_day])
      @target_day = params[:target_day]
    end
  end

  def show
  end
  
  def new
    @category = Category.new
  end  

  def create
    @category = Category.new(category_params)
    @category.update(user_id: current_user.id)

    if @category.save
      redirect_to calendar_path
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
    if session[:target_day].nil?
      redirect_to calendar_path
    else
      redirect_to categories_path(target_day: session[:target_day])
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
    session[:target_day] = @category.target_date.to_date
  end

  def set_target_day
    @target_day = params[:target_day]
  end

  def category_params
    params.require(:category).permit(:title, :target_date, :user_id, :previous_request)
  end
end
