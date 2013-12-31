class Comic

  def self.make
    if @comics.nil?
      @comics = []
      text = File.open('comics.txt').read
      text.each_line do |line|
        c = line.split(",")
        @comics << [c[0].strip, c[1].strip]
      end
    end

    @comics
  end

  def self.xkcd
    url = "http://xkcd.com"

    output = "<div><strong>XKCD</strong></div>"
    output << "<div>Searching... <a href=\"#{url}\">#{url}</a></div>"

    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    response = Net::HTTP.get_response(uri)

    if response.code == "200"
      lines = response.body.split(/\n/)
      lines.each do |l|
        output << "<div>#{l}</div>" if l.match(/imgs.xkcd.com\/comics/)
      end
    else
      output << "<div>Response code is #{response.code}</div>"
    end

    output
  end

  def self.display(title, path)
    d = Time.now.to_date
    mon = "#{d.mon}"
    mon = "0#{mon}" if mon.length == 1
    url = "http://www.gocomics.com/#{path}/#{d.year}/#{mon}/#{d.mday}"

    output = "<div><strong>#{title}</strong></div>"
    output << "<div>Searching... <a href=\"#{url}\">#{url}</a></div>"

    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    response = Net::HTTP.get_response(uri)

    if response.code == "200"
      lines = response.body.split(/\n/)
      lines.each do |l|
        output << "<div>#{l}</div>" if l.match(/feature_item/)
      end
    else
      output << "<div>Response code is #{response.code}</div>"
    end

    output
  end
end
