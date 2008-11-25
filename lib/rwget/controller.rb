class RWGet::Controller
  attr_reader :options
  
  def initialize(options)
    @options = options
  end
  
  def start
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