class Comic

  def self.make
    if @comics.nil?
      @comics = []
      text = File.open('comics.txt').read
      text.each_line do |line|
        @comics << line.split(",")
      end
    end

    @comics
  end
end
