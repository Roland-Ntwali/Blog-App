class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @users = User.find(params[:id])
    @posts = Post.find(params[:id])
  end
end
