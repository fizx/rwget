require "fileutils"
class RWGet::Store
  include FileUtils
  
  attr_accessor :root
  
  def initialize(options = {})
    @root = "."
  end
  
  def put(key, tmpfile)
    path = File.join(@root, key)
    mkdir_p(File.dirname(path))
    mv tmpfile.path, path
  end
end