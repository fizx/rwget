require "set"
class RWGet::Controller
  attr_reader :options
  
  def initialize(options)
    @options = options
    @options[:user_agent] ||= "Ruby/Wget" 
    
    @options[:accept_patterns] ||= []
    @options[:reject_patterns] ||= []
        
    %w[quota depth wait limit_rate].each do |key|
      key = key.to_sym
      @options[key] = @options[key].to_i
    end
    
    @queue = (options[:queue_class] ? Kernel.const_get(options[:queue_class]) : RWGet::Queue).new(options)
    @fetch = (options[:fetch_class] ? Kernel.const_get(options[:fetch_class]) : RWGet::Fetch).new(options)
    @store = (options[:store_class] ? Kernel.const_get(options[:store_class]) : RWGet::Store).new(options)
    @links = (options[:links_class] ? Kernel.const_get(options[:links_class]) : RWGet::Links).new(options)
    @dupes = (options[:dupes_class] ? Kernel.const_get(options[:dupes_class]) : RWGet::Dupes).new(options)
  end
  
  def start
    @start_time = Time.now.to_i.to_s
    @start = Time.now
    @original_hosts = Set.new
    options[:seeds].each do |seed| 
      @queue.put(seed, 0) 
      @original_hosts << URI.parse(seed).host
    end
    
    downloaded = 0
    while (options[:quota] == 0 || downloaded < options[:quota]) 
      url, depth = @queue.get
      
      unless url
        puts "no more urls"
        exit
      end
      
      if options[:depth] > 0 && depth >= options[:depth]
        next 
      end
      
      uri = URI.parse(url)
      
      while options[:limit_rate] > 0 && downloaded / (Time.now - @start) > options[:limit_rate]
        puts "sleeping until under rate limit"
        sleep 1 
      end
      puts "download rate: #{downloaded / (Time.now - @start)}bps"
      
      puts "downloading #{uri}"
      effective_url, tmpfile = @fetch.fetch(uri, options[:user_agent])
      
      if tmpfile
        downloaded += File.size(tmpfile.path)
        puts "parsing links"
        @links.urls(effective_url, tmpfile).each do |link|
          @queue.put(link, depth + 1) if legal?(link) && !@dupes.dupe?(link)
        end
        key = key_for(uri)
        puts "storing at #{key}"
        @store.put(key, tmpfile)
        sleep options[:wait]
      else
        puts "unable to download"
      end
    end
  end
  
  def legal?(link)
    options[:span_hosts] || @original_hosts.include?(link.host)
    link = link.to_s
    legal = options[:accept_patterns].empty?
    legal ||= options[:accept_patterns].any?{|p| link =~ p}
    rejected = options[:reject_patterns].any?{|p| link =~ p}
    legal && !rejected
  end
  
  def key_for(uri)
    arr = []
    arr << options[:prefix]     if options[:prefix]
    arr << @start_time        if options[:timestampize]
    arr << uri.scheme           if options[:protocol_directories]
    arr << uri.host             unless options[:no_host_directories]
    paths = uri.path.split("/")
    paths.shift                 if paths.first.to_s.empty?
    paths.push "index.html"     unless paths.last.to_s =~ /\.|\?/
    File.join(arr + paths)
  end
end