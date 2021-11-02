class TasksController < ApplicationController
  before_action :set_user, only: [:new, :index, :create, :show, :edit, :update]
  before_action :admin_or_correct_user, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  before_action :set_task, only: [:new, :create, :show, :edit, :update, :destroy]
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
    @task = Task.new(task_params)
    if @user.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url
    else
      render :new
      
    end
  end

  def edit
  end

  def update
     @user = User.find(params[:user_id])
    if @user.update_attributes(task_params)	
    flash[:success] = "タスクを更新しました。"	
    redirect_to user_task_url @user
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
      params.permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_task
      @task_id = @user.tasks.find_by(id: params[:id])
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
      @user = find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_path
      end
    end
end