class TasksController < ApplicationController
  before_action :set_task,only:[ :show, :edit, :update, :destroy ]
  before_action :authenticate_user, only:[:index, :new, :show, :edit, :update, :destroy]
  before_action :ensure_current_user_task_check, only:[:show, :edit, :update, :destroy]
  def new
    @task = Task.new
  end

  def index
    if params[:sort_deadline]
      @tasks = Task.all.sort_deadline.pagination(params)
    elsif params[:sort_priority]
      @tasks = Task.all.sort_priority.pagination(params)
    elsif params[:title].present? && params[:status].present?
        @tasks = Task.where(title: params[:title]).pagination(params)
        @tasks = @tasks.where(status: params[:status]).pagination(params)
    elsif params[:title].present?
      @tasks = Task.where(title: params[:title]).pagination(params)
    elsif params[:status].present?
      @tasks = Task.where(status: params[:status]).pagination(params)
    else
      @tasks = Task.all.order(created_at: "DESC").pagination(params)
    end
   end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: ('作成されました')
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:"タスクを更新しました"
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end
  private
  def task_params
    params.require(:task).permit(:title,:content,:status,:deadline,:priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
