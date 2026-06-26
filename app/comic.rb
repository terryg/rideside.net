# frozen_string_literal: true

# Generate comic strip entries
class Comic
  def self.make
    return if @comics

    @comics = []

    text = File.read(File.join('app', 'comics.txt'))
    text.each_line do |line|
      c = line.split(',')
      @comics << [c[0].strip, c[1].strip]
    end

    @comics
  end

  def self.xkcd
    make_output('XKCD', 'https://xkcd.com', %r{imgs.xkcd.com/comics})
  end

  def self.display(title, path)
    d = Time.now.to_date
    mon = d.mon.to_s
    mon = "0#{mon}" if mon.length == 1
    url = "https://www.gocomics.com/#{path}/#{d.year}/#{mon}/#{d.mday}"

    make_output(title, url, /item-comic-image/)
  end

  def self.make_output(title, url, pattern)
    response = Net::HTTP.get_response(URI.parse(CGI.escape(url)))
    return "Response code is #{response.code}" if response.code != '200'

    tokens = []
    response.body.split(/\n/).each do |line|
      tokens << line if line.match(pattern)
    end

    engine = Haml::Template.new(File.open(File.join('app', 'views', 'comic.haml')).read)
    engine.render({ tokens:, title:, url: })
  end
end
