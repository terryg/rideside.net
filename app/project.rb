# frozen_string_literal: true

# Project helper class
class Project
  attr_accessor :topic, :description, :imgpath, :imgwidth, :projectlink

  def initialize(attr)
    if attr.is_a?(Array)
      init_from_array(attr)
    else
      self.topic = attr[:topic]
      self.description = attr[:description]
      self.imgpath = attr[:imgpath]
      self.imgwidth = attr[:imgwidth]
      self.projectlink = attr[:projectlink]
    end
  end

  def self.make
    return if @projects

    @projects = []
    text = File.read(File.join('app', 'projects.txt'))
    text.each_line do |line|
      c = line.split(',')
      @projects << Project.new(c)
    end

    @projects
  end

  private

  def init_from_array(attr)
    self.topic = attr[0]
    self.description = attr[2]
    self.imgpath = attr[3]
    self.imgwidth = attr[4]
    self.projectlink = attr[5]
  end
end
