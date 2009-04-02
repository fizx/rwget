require 'optparse'

class RWGetOptionParser < OptionParser
  attr_accessor :options
  
  def usage
    "Usage: #{$0} [options] SEED_URL [SEED_URL2 ...]"
  end
  
  def parse!
    super
    options[:seeds] = ARGV
  end
  
  def initialize
    self.options = {}
    super do |opts|
      
      yield opts if block_given?
  
      opts.banner = usage
  
      opts.on("-w", "--wait=SECONDS", "wait SECONDS between retrievals.") do |w|
        options[:wait] = w.to_i
      end
  
      opts.on("-P", "--directory-prefix=PREFIX", "save files to PREFIX/...") do |p|
        options[:prefix] = p
      end
  
      opts.on("-U", "--user-agent=AGENT", "identify as AGENT instead of RWget/VERSION.") do |u|
        options[:user_agent] = u
      end

      opts.on("-Ap", "--accept-pattern=RUBY_REGEX", "URLs must match RUBY_REGEX to be saved to the queue.") do |r|
        options[:accept_patterns] ||= []
        options[:accept_patterns] << Regexp.new(r)
      end

      opts.on("--time-limit=AMOUNT", "Crawler will stop after this AMOUNT of time has passed.") do |t|
        options[:time_limit] = t.to_i
        options[:time_limit] *= 60 if t =~ /m/i
        options[:time_limit] *= 60 * 60 if t =~ /h/i
        options[:time_limit] *= 60 * 60 * 24 if t =~ /d/i
        options[:time_limit] *= 60 * 60 * 24 * 7 if t =~ /w/i
      end
  
      opts.on("-Rp", "--reject-pattern=RUBY_REGEX", "URLs must NOT match RUBY_REGEX to be saved to the queue.") do |r|
        options[:reject_patterns] ||= []
        options[:reject_patterns] << Regexp.new(r)
      end

      opts.on("--require=RUBY_SCRIPT", "Will execute 'require RUBY_SCRIPT'") do |s|
        require s
      end
  
      opts.on("--limit-rate=RATE", "limit download rate to RATE.") do |r|
        rate = r.to_i
        rate *= 1000 if r =~ /k/i
        rate *= 1000000 if r =~ /m/i
        options[:limit_rate] = rate
        puts "rate is #{rate}"
      end
  
      opts.on("--http-proxy=URL", "Proxies via URL") do |u|
        options[:http_proxy] = u
      end
  
      opts.on("--proxy-user=USER", "Sets proxy user to USER") do |u|
        options[:proxy_user] = u
      end
  
      opts.on("--proxy-password=PASSWORD", "Sets proxy password to PASSWORD") do |p|
        options[:proxy_password] = p
      end
  
      opts.on("--fetch-class=RUBY_CLASS", "Must implement fetch(uri, user_agent_string) #=> [final_redirected_url, file_object]") do |c|
        options[:fetch_class] = c
      end
  
      opts.on("--store-class=RUBY_CLASS", "Must implement put(key_string, temp_file)") do |c|
        options[:store_class] = c
      end
  
      opts.on("--dupes-class=RUBY_CLASS", "Must implement dupe?(uri)") do |c|
        options[:dupes_class] = c
      end
  
      opts.on("--queue-class=RUBY_CLASS", "Must implement put(key_string, depth_int) and get() #=> [key_string, depth_int]") do |c|
        options[:queue_class] = c
      end
  
      opts.on("--queue-class=RUBY_CLASS", "Must implement put(key_string, depth_int) and get() #=> [key_string, depth_int]") do |c|
        options[:queue_class] = c
      end
  
      opts.on("--links-class=RUBY_CLASS", "Must implement urls(base_uri, temp_file) #=> [uri, ...]") do |c|
        options[:links_class] = c
      end
  
      opts.on("-Q", "--quota=NUMBER", "set retrieval quota to NUMBER.") do |q|
        options[:quota] = q.to_i
        options[:quota] *= 1000 if q =~ /k/i
        options[:quota] *= 1000000 if q =~ /m/i
      end
  
      opts.on("--max-redirect=NUM", "maximum redirections allowed per page.") do |m|
        options[:max_redirect] = m.to_i
      end
  
      opts.on("-H", "--span-hosts", "go to foreign hosts when recursive") do |s|
        options[:span_hosts] = s
      end
  
      opts.on("--connect-timeout=SECS", "set the connect timeout to SECS.") do |t|
        options[:connect_timeout] = t.to_i
      end
  
      opts.on("-T", "--timeout=SECS", "set all timeout values to SECONDS.") do |t|
        options[:timeout] = t.to_i
      end
  
      opts.on("-l", "--level=NUMBER", "maximum recursion depth (inf or 0 for infinite).") do |l|
        options[:depth] = l.to_i
      end
  
      opts.on("--[no-]timestampize", "Prepend the timestamp of when the crawl started to the directory structure.") do |t|
        options[:timestampize] = t
      end
  
      opts.on("--incremental-from=PREVIOUS", "Build upon the indexing already saved in PREVIOUS.") do |r|
        options[:incremental_from] = r
      end
  
      opts.on("--protocol-directories", "use protocol name in directories.") do |p|
        options[:protocol_directories] = p
      end
  
      opts.on("--no-host-directories", "don't create host directories.") do |h|
        options[:no_host_directories] = h
      end
  
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
  
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
  end
end