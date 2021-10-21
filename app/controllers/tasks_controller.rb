class TasksController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :show]
  
  def index
    @tasks = @user.tasks
  end

  def show
  end

  def new
    @tasks = Task.new
  end
    
  def create
    @tasks = Task.new(task_params)
    if @tasks.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to tasks_index_url
    else
      render :task
      
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)	
    flash[:success] = "タスクを更新しました。"	
    redirect_to @user_id, @task_id
    else	
    render :edit	
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end

  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger]
        redirect_to login_url
      end
    end
    
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def set_task
      unless @task_id = @user.tasks.find_by(id: params[:id])
      flash[:danger] = "権限がありません。"
      redirect_to user_tasks_url @user
      end
    end
end



