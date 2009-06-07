require "fileutils"
class RWGet::Store
  include FileUtils
  
  attr_accessor :root
  
  def initialize(options = {})
    @root = "."
  end
  
  def put(key, tmpfile)
    path = File.join(@root, key)
    path = File.join(path, "index.html")     unless path.split("/").last =~ /\.|\?/
    mkdir_p(File.dirname(path))
    mv tmpfile.path, path
  end
end