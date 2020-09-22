class Api::UsersController < ApplicationController
  def index
    jsonplaceholder = Jsonplaceholder::User.new
    @users = jsonplaceholder.all
    
    @users.map! { |user| { name: user['name'], count_posts: user['count_posts'] } } 
    render json: @users
  end

  def influencers
    jsonplaceholder = Jsonplaceholder::User.new
    @users = jsonplaceholder.influencers

    render json: @users
  end
end