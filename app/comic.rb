# frozen_string_literal: true

require 'net/http'
require 'nokogiri'
require 'uri'

# Generate comic strip entries
class Comic
  IMAGE_HOSTS = {
    'xkcd.com' => %w[imgs.xkcd.com],
    'www.gocomics.com' => %w[assets.amuniversal.com featureassets.gocomics.com]
  }.freeze

  def self.make
    return @comics if @comics

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
    response = fetch_response(url)
    return render_output(title, url, [], 'Comic unavailable') unless response&.code == '200'

    tokens = Nokogiri::HTML.fragment(response.body).css('img').filter_map do |image|
      image_url(image, url, pattern)
    end

    render_output(title, url, tokens, tokens.empty? ? 'Comic unavailable' : nil)
  end

  def self.fetch_response(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    http.open_timeout = 5
    http.read_timeout = 5
    http.start { |connection| connection.get(uri.request_uri) }
  rescue StandardError
    nil
  end

  def self.image_url(image, url, pattern)
    source = image['src']
    return unless source && pattern.match?("#{source} #{image['class']}")

    uri = URI.join(url, source)
    allowed_hosts = IMAGE_HOSTS[URI.parse(url).host]
    return unless uri.scheme == 'https' && uri.port == 443 && uri.userinfo.nil? && allowed_hosts&.include?(uri.host)

    uri.to_s
  rescue URI::InvalidURIError
    nil
  end

  def self.render_output(title, url, tokens, fallback)
    template = File.join('app', 'views', 'comic.haml')
    engine = Haml::Template.new(template) { File.read(template) }
    engine.render(Object.new, tokens:, title:, url:, fallback:)
  end
end
