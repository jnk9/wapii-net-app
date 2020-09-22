module Jsonplaceholder
  class Post < Base

    def initialize; end

    def all(start = nil, limit = nil)
      response = self.class.get("/posts?_star#{start}t=&_limit=#{limit}")
      posts = JSON.parse(response.body)
      add_hash_count_comments(posts)
      add_hash_name(posts)
      add_hash_comments(posts)
    end


    def find(post_id)
      response = self.class.get("/posts/#{post_id}")
      post = JSON.parse(response.body)
      post['count_comments'] = add_hash_count_comments(post)
      post['comments'] = add_hash_comments(post)
      post['user_name'] = add_hash_name(post)
      
      post
    end

    def trending(limit = 5)
      sort_by_desc(all, 'count_comments')[0..(limit.to_i - 1)].map do |post|
        {
          id: post['id'],
          title: post['title'],
          body: post['body'],
          count_comments: post['count_comments']
        }
      end
    end

    private

    def add_hash_count_comments(object)
      if object.is_a?(Array)
        object.each do |post|
          post['count_comments'] = count_comments(post['id'])
        end
      else
        count_comments(object['id'])
      end
    end

    def add_hash_name(object)
      jsonplaceholder = Jsonplaceholder::User.new

      if object.is_a?(Array)
        object.each do |post|
          user = jsonplaceholder.find(post['userId'])
          post['user_name'] = user['name']
        end
      else
        user = jsonplaceholder.find(object['userId'])
        user['name']
      end
      
    end

    def add_hash_comments(object)
      if object.is_a?(Array)
        object.each do |post|
          post['comments'] = comments(post['id'], 1, 3)
        end
      else
        comments(object['id'])
      end
    end

    def comments(post_id, start = nil, limit = nil)
      response = self.class.get("/posts/#{post_id}/comments?_star#{start}t=&_limit=#{limit}")
      comments = JSON.parse(response.body)
    end
    
    def count_comments(post_id)
      comments(post_id).count
    end
  end
end