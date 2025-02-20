class Project

  attr_accessor :topic
  attr_accessor :description
  attr_accessor :imgpath
  attr_accessor :imgwidth
  attr_accessor :projectlink

  def initialize(attr)
    self.topic = attr[:topic]
    self.description = attr[:description]
    self.imgpath = attr[:imgpath]
    self.imgwidth = attr[:imgwidth]
    self.projectlink = attr[:projectlink]
  end
end
