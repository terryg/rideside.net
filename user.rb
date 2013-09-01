class User

  def self.get_all
    if @users.nil?
      @users = []
      text = File.open('users.txt').read
      text.each_line do |line|
        @users << line.gsub(/\n/, "")
      end
    end

    return @users
  end

end
