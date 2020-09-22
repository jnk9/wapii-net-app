class PostsController < ApplicationController
  def index
    @start = params['start'].present? ? params['start'].to_i : 1

    jsonplaceholder = Jsonplaceholder::Post.new
    @posts = jsonplaceholder.all(@start, 10)
  end

  def show
    jsonplaceholder = Jsonplaceholder::Post.new
    @post = jsonplaceholder.find(params[:id])
  end
end