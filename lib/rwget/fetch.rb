require "open-uri"
require "tempfile"
class RWGet::Fetch
  def initialize
  end
  
  def fetch(uri, user_agent)
    io = open uri, "User-Agent" => user_agent
    return io if io.is_a?(Tempfile)
    tmp = nil
    Tempfile.open("rwget-fetch") do |file|
      file.print(io.read)
      tmp = file
    end
    tmp
  rescue Exception => e 
    STDERR.puts "#{uri} not retrieved: #{e.message}"
    nil
  end
end
