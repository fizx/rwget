require "tempfile"
class RWGet::Queue
  def initialize(options = {})
    @writer = Tempfile.new("rwget-queue")
    @reader = File.open(@writer.path, "r")
    @dirty = false
  end
  
  def put(key, depth)
    @writer.puts "#{key}\t#{depth}"
    @dirty = true
  end
  
  def get(retrying = false)
    sleep 0.1 if retrying
    if @dirty
      @writer.flush 
      @dirty = false
    end
    line = @reader.gets
    unless line
      return retrying ? nil : get(:retry)
    end
    key, depth = line.split("\t")
    return [key, depth.to_i]
  end
  
  def close
    @writer.close
    @reader.close
  end
end
