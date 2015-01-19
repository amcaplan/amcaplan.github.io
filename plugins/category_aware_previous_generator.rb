module Jekyll
  class CategoryAwarePreviousGenerator < Generator
 
    safe true
    priority :high
 
    def generate(site)
      site.categories.each_pair do |category_name, posts|
        posts.sort.each_with_index do |post, index|
          category_prev = if index > 0
             posts[index - 1]
          end
 
          post.data["#{category_name}_prev"] = category_prev if category_prev
        end
      end
    end
  end
end
