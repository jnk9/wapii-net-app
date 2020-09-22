class PostsController < ApplicationController
  def index
    jsonplaceholder = Jsonplaceholder::Post.new
    @posts = jsonplaceholder.all(1, 10)
  end

  def show
    jsonplaceholder = Jsonplaceholder::Post.new
    @post = jsonplaceholder.find(params[:id])
  end
end