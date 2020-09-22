module Jsonplaceholder
  class User < Base

    def initialize; end
    
    def all
      response = self.class.get('/users')
      users = JSON.parse(response.body)
      users_sort = sort_by_desc(users, 'id')
      add_hash_count_posts(users_sort)
    end

    def find(user_id)
      response = self.class.get("/users/#{user_id}")
      user = JSON.parse(response.body)
    end

    def influencers
      all.map do |user|
        {
          id: user['id'],
          name: user['name'],
          popularity_index: popularity_index(user['id'])
        }
      end
    end

    private 

    def popularity_index(user_id)
      (count_comments_all_posts(user_id) / count_posts(user_id)).to_f
    end

    def count_posts(user_id)
      response = self.class.get("/users/#{user_id}/posts")
      count = JSON.parse(response.body).count
      count
    end

    def count_comments_all_posts(user_id)
      response = self.class.get("/users/#{user_id}/posts")
      posts = JSON.parse(response.body)
      jsonplaceholder_post = Jsonplaceholder::Post.new
      counter = 0

      posts.each do |post| 
        counter += jsonplaceholder_post.find(post['id'])['count_comments']
      end

      counter
    end

    def add_hash_count_posts(recipent)
      recipent.each do |user|
        user['count_posts'] = count_posts(user['id'])
      end
    end
  end
end