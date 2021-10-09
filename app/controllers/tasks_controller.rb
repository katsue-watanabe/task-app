class TasksController < ApplicationController
end

def index
  @tasks = @user.tasks
end

def show
end

def new
  @task = Task.new
end

def created
  if @task = @user.task.build(task_params)
     flash[:success] = "タスクを新規作成しました。"
     redirect_to tasus_index_url @user
  else
     render :new
  end
end

def edit
end

def update
end

def destroy
  @task.destroy
  flash[:success] = "タスクを削除しました。"
  redirect_to tasks_index_url @user
end

private

  def task_params
    params.require(:task).parmit(:name, :email, :password, :password_confirmation)
  end