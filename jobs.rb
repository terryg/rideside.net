class Jobs

  def self.get_resume
    uri = URI('https://raw.githubusercontent.com/terryg/resume/master/README.md')
    response = Net::HTTP.get(uri)   
    
    File.open('views/resume.haml', 'w') { |file| 
      file.write(".content\n")
      file.write("  :markdown\n")
      response.each_line { |line|
        file.write("    ")				
        file.write(line)
      }	
    }

  end

end
