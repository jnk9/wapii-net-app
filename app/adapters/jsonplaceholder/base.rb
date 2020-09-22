module Jsonplaceholder
  class Base
    include HTTParty

    base_uri 'jsonplaceholder.typicode.com'

    def sort_by_desc(recipent, key)
      recipent.sort_by { |hash| hash["#{key}"] }.reverse
    end
  end
end