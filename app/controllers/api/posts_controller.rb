class Api::PostsController < ApplicationController
  def trending
    jsonplaceholder = Jsonplaceholder::Post.new
    @posts = jsonplaceholder.trending(params['limit'])
    
    render json: @posts
  end
end