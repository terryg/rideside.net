class Comic

  def self.make
    if @comics.nil?
      @comics = []
      text = File.open('comics.txt').read
      text.each_line do |line|
        c = line.split(",")
        if c and c[0] and c[1]
          @comics << [c[0].strip, c[1].strip]
        else
          puts "*** Something is wrong with #{line} ***"
        end
      end
    end

    @comics
  end

  def self.xkcd
    make_output("XKCD", "https://xkcd.com", /imgs.xkcd.com\/comics/)
  end

  def self.display(title, path)
    d = Time.now.to_date
    mon = "#{d.mon}"
    mon = "0#{mon}" if mon.length == 1
    url = "https://www.gocomics.com/#{path}/#{d.year}/#{mon}/#{d.mday}"

    make_output(title, url, /item-comic-image/)
  end

  protected

  def self.make_output(title, url, pattern)
    output = "<div><strong>#{title}</strong></div>"
		output << "<div><em>Source</em>: <a href=\"#{url}\">#{url}</a></div>"

    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    response = Net::HTTP.get_response(uri)

    if response.code == "200"
      lines = response.body.split(/\n/)
      lines.each do |l|
        if l.match(pattern)
          puts "MATCHED #{l}"
          output << "<div>#{l}</div>"
        end
      end
    else
      output << "<div>Response code is #{response.code}</div>"
    end

    output  
  end

end
