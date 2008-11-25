class RWGet::Controller
  attr_reader :options
  
  def initialize(options)
    @options = options
    @options[:user_agent] ||= "Ruby/Wget" 
    @queue = options[:queue_class] ? Kernel.const_get(options[:queue_class]) : Queue.new
    @fetch = options[:fetch_class] ? Kernel.const_get(options[:fetch_class]) : Fetch.new
    @store = options[:store_class] ? Kernel.const_get(options[:store_class]) : Store.new
    @links = options[:links_class] ? Kernel.const_get(options[:links_class]) : Links.new
    @dupes = options[:dupes_class] ? Kernel.const_get(options[:dupes_class]) : Dupes.new
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
      ua = options[:user_agent] || "Ruby/Wget"
      tmpfile = @fetch.fetch(uri, ua)
      
      if tmpfile
        @links.urls(uri, tmpfile).each do |link|
          @queue.put(link) unless @dupes.dupe?(link)
        end
        @store.put(key_for(uri), tmpfile)
        downloaded += 1
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