class Post

  attr_accessor :blog_name
  attr_accessor :date
  attr_accessor :post_url
  attr_accessor :title
  attr_accessor :description
  attr_accessor :body

  def initialize(attr)
    if attr['type'] == 'photo'
      self.blog_name = attr['blog_name']
      self.date = attr['date']
      self.post_url = attr['post_url']
      self.title = ""
      self.description = ""

      link = attr['photos'][0]['original_size']['url']
      self.body = "<img src=\"#{link}\"/><br/><strong>#{attr['caption']}</strong>"
    elsif attr['type'] == 'video'
      self.blog_name = attr['blog_name']
      self.date = attr['date']
      self.post_url = attr['post_url']
      self.title = attr['title']
      self.description = attr['description']
      self.body = attr['player'][0]['embed_code']

    elsif attr['type'] == 'text'
      self.blog_name = attr['blog_name']
      self.date = attr['date']
      self.post_url = attr['post_url']
      self.title = attr['title']
      self.description = attr['description']
      self.body = attr['body']

    elsif attr['type'] == 'link'
      self.blog_name = attr['blog_name']
      self.date = attr['date']
      self.post_url = attr['post_url']
      self.title = attr['title']
      self.description = attr['description']
      self.body = "<a href=\"#{attr['url']}\" _target=\"blank\">&gt;&gt;</a>"

    else
      puts "*** #{attr}"

      self.blog_name = attr['blog_name']
      self.date = attr['date']
      self.post_url = attr['post_url']
      self.title = attr['title']
      self.description = attr['description']
      self.body = attr['body']

    end
  end
end
