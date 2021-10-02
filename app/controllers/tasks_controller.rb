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