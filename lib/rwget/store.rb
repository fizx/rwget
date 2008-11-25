require "fileutils"
class RWGet::Store
  include FileUtils
  
  def initialize(root = ".")
    @root = root
  end
  
  def put(key, tmpfile)
    path = File.join(@root, key)
    mkdir_p(File.dirname(path))
    mv tmpfile.path, path
  end
end