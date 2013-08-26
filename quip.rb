class Quip

  def self.make
    if @quips.nil?
      @quips = []
      text = File.open('quips.txt').read
      text.each_line do |line|
        @quips << line
      end
    end

    length = @quips.length
    @quips[rand(length)]    
  end
end
