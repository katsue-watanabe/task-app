class TasksController < ApplicationController
  before_action :set_user, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  before_action :admin_or_correct_user, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  before_action :set_task, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :show]
  
  def new
    @task = Task.new
  end
    
  def create
    @task = @user.tasks.new(task_params)
    if @user.save
      log_in @user
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url(@user, @task)
    else
      render :new
    end
  end
  
  def index
    @tasks = @user.tasks.all.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)	
    flash[:success] = "タスクを更新しました。"	
    redirect_to user_task_url(@user, @task)
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
    
    def set_task
      @task = @user.tasks.find_by(id: params[:id])
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
    
    def admin_or_correct_user
      @task = find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_path
      end
    end
end