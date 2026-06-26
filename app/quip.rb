# frozen_string_literal: true

# Helper class to issue a random quip
class Quip
  def self.make
    if @quips.nil?
      @quips = []
      text = File.read(File.join('app', 'quips.txt'))
      text.each_line do |line|
        @quips << line
      end
    end

    length = @quips.length
    @quips[rand(length)]
  end
end
