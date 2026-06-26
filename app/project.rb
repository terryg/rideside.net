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

  def self.projects
    @projects ||= begin
      text = File.read(File.join('app', 'projects.txt'))
      projects = []
      text.each_line do |line|
        projects << Project.new(line.split(','))
      end
      projects
    end
  end

  private

  def init_from_array(attr)
    self.topic = attr[0]
    self.description = attr[1]
    self.imgpath = attr[2]
    self.imgwidth = attr[3]
    self.projectlink = attr[4]
  end
end
