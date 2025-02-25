# frozen_string_literal: true

# Factory pattern for transforming Tumblr API response into a Post object.
class PostFactory
  @mapping = [
    { type: 'photo', object: PhotoPost },
    { type: 'video', object: VideoPost },
    { type: 'text', object: TextPost },
    { type: 'link', object: LinkPost }
  ]

  def self.create(attr)
    @mapping.each do |mapping|
      return mapping[:object].new(attr) if attr['type'] == mapping[:type]
    end

    Post.new(attr)
  end
end
