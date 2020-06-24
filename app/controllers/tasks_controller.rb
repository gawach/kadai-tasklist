class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy ]
  before_action :correct_user, only: [:show,:edit, :update, :destroy]

  def index
    @task = current_user.tasks.build
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def new
    @task = Task.new
  end
  
  def show
    if current_user != @task.user
      redirect_to root_url
    end
  end

  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが追加されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクが追加されませんでした'
      render 'tasks/new'
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
    def set_task
      @task = current_user.tasks.find_by(id: params[:id])
    end
  
    def task_params
      params.require(:task).permit(:content, :status)
    end
    
    def correct_user
      unless @task
        redirect_to root_url
      end
    end
    
end
