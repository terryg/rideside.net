# frozen_string_literal: true

# A Tumblr post
class Post
  attr_accessor :blog_name, :date, :post_url, :title, :description, :body

  def initialize(attr)
    self.blog_name = attr['blog_name']
    self.date = attr['date']
    self.post_url = attr['post_url']
    self.title = attr['title']
    self.description = attr['description']
    self.body = attr['body']
  end
end

# A post of a photo
class PhotoPost < Post
  def initialize(attr)
    super
    self.title = ''
    self.description = ''
    link = attr['photos'][0]['original_size']['url']
    self.body = "<img src=\"#{link}\"/><br/><strong>#{attr['caption']}</strong>"
  end
end

# A video post
class VideoPost < Post
  def initialize(attr)
    super
    self.body = attr['player'][0]['embed_code']
  end
end

# Text post
class TextPost < Post
  def initialize(attr)
    super
    self.body = attr['body']
  end
end

# Link post
class LinkPost < Post
  def initialize(attr)
    super
    self.body = "<a href=\"#{attr['url']}\" _target=\"blank\">&gt;&gt;</a>"
  end
end
