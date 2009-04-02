require "open-uri"
require "tempfile"
require "rubygems"
require "robots"
require "curl"
class RWGet::Fetch
  DEFAULT_TIMEOUT = 30
  DEFAULT_REDIRECTS = 30
  
  def initialize(options = {})
    @robots = {}
    @curl = Curl::Easy.new
    @curl.connect_timeout = options[:connect_timeout] || DEFAULT_TIMEOUT
    @curl.timeout = options[:timeout] || DEFAULT_TIMEOUT
    @curl.max_redirects = options[:max_redirect] || DEFAULT_REDIRECTS
    @curl.follow_location = true
    if options[:http_proxy]
      @curl.proxy_url = options[:http_proxy]
      if options[:proxy_user]
        @curl.proxypwd = "#{options[:proxy_user]}:#{options[:proxy_password]}"
      end
    end
    puts "timeout: #{@curl.timeout}"
  end
  
  def fetch(uri, user_agent)
    @robots[user_agent] ||= Robots.new(user_agent)
    unless @robots[user_agent].allowed?(uri)
      puts "disallowed by robots.txt"
      return nil 
    end
    
    @curl.headers["User-Agent"] = user_agent
    @curl.url = uri.to_s
    @curl.perform
    tmp = nil
    Tempfile.open("curl") {|file| file.print(@curl.body_str); tmp = file }
    [@curl.last_effective_url, tmp]
  rescue Exception => e 
    STDERR.puts "#{uri} not retrieved: #{e.message}"
    nil
  end
end
