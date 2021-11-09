class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_current_user
end

def set_current_user
  @current_user = User.find(session[:user_id])
end

def limitation_login_user
  if @current_user
  flash[:danger] = "すでにログインしています。"
  redirect_to user_url(current_user)
  end
end
