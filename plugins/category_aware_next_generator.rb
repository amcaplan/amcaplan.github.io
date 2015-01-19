module Jekyll
  class CategoryAwareNextGenerator < Generator
 
    safe true
    priority :high
 
    def generate(site)
      site.categories.each_pair do |category_name, posts|
        posts.sort.each_with_index do |post, index|
          category_next = if index < posts.length - 1
             posts[index + 1]
          end
 
          post.data["#{category_name}_next"] = category_next if category_next
        end
      end
    end
  end
end
