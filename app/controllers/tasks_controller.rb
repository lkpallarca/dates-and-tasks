class TasksController < ApplicationController
  before_action :find_category
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)

    if @category.save
      redirect_to category_path(@category), notice: 'Task is successfully created!'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category)
  end

  private
  
  def find_category
    @category = current_user.categories.find(params[:category_id])
  end
  
  def set_task
    @task = @category.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :body, :status)
  end
end
