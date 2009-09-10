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
    dir = File.dirname(path)
    if(File.file?(dir))
      tmp = "#{dir}.index.html.#{Time.now.to_f}"
      mv dir, tmp
      mkdir_p(dir)
      mv tmp, File.join(dir, "index.html")
    else
      mkdir_p(dir)
    end
    mv tmpfile.path, path
  end
end