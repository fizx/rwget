class RWGet::Controller
  attr_reader :options
  
  def initialize(options)
    @options = options
    @options[:user_agent] ||= "Ruby/Wget" 
    
    %w[quota depth wait].each do |key|
      key = key.to_sym
      @options[key] = @options[key].to_i
    end
    
    @queue = options[:queue_class] ? Kernel.const_get(options[:queue_class]) : RWGet::Queue.new
    @fetch = options[:fetch_class] ? Kernel.const_get(options[:fetch_class]) : RWGet::Fetch.new
    @store = options[:store_class] ? Kernel.const_get(options[:store_class]) : RWGet::Store.new
    @links = options[:links_class] ? Kernel.const_get(options[:links_class]) : RWGet::Links.new
    @dupes = options[:dupes_class] ? Kernel.const_get(options[:dupes_class]) : RWGet::Dupes.new
  end
  
  def start
    options[:seeds].each {|seed| @queue.put(seed, 0) }
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
      
      puts "downloading #{uri}"
      tmpfile = @fetch.fetch(uri, options[:user_agent])
      
      if tmpfile
        downloaded += tmpfile.size
        puts "parsing links"
        @links.urls(uri, tmpfile).each do |link|
          @queue.put(link, depth + 1) unless @dupes.dupe?(link)
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
  
  def key_for(uri)
    arr = []
    arr << options[:prefix]     if options[:prefix]
    arr << Time.now.to_i        if options[:timestampize]
    arr << uri.scheme           if options[:protocol_directories]
    arr << uri.host             unless options[:no_host_directories]
    paths = uri.path.split("/")
    paths.shift                 if paths.first.to_s.empty?
    paths.push "index.html"     unless paths.last.to_s =~ /\.|\?/
    File.join(arr + paths)
  end
end