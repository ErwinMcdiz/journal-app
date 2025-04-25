class TasksController < ApplicationController
  before_action :set_category, only: %i[index new create show edit update destroy]   
  before_action :set_task, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @task = @category.tasks.new
  end

  def index
    @tasks = @category.tasks
  end

  def show
    @task = Task.find(params[:id])
    @category = @task.category
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_back fallback_location: category_tasks_path(@task.category)
  end
  
  

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(@category), notice: "Updated successfully."
    else
      flash[:alert] = "Oh no! Updated unsuccessfully."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      redirect_to category_path(@category), status: :see_other
      flash[:alert] = "Deleted successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @task = @category.tasks.new(task_params)
    @task.user = current_user
  
    if @task.save
      redirect_to @category, notice: "Task was successfully created."
    else
      flash[:alert] = "There were some problems with your submission."
      render "categories/show", status: :unprocessable_entity
    end
  end
  

  private
  
  def task_params
    params.require(:task).permit(:title, :content, :due_date, :mood, :completed, :category_id)
  end
  

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def record_not_found
    redirect_to root_path, alert: "Record does not exist"
  end
end
