# frozen_string_literal: true

# Helper to parse the users.txt datastore
class User
  def self.all
    if @users.nil?
      @users = []
      text = File.read(File.join('app', 'users.txt'))
      text.each_line do |line|
        @users << line.gsub(/\n/, '')
      end
    end

    @users
  end
end
