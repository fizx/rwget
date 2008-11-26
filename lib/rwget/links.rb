require "rubygems"
require "hpricot"
class RWGet::Links
  def initialize(options = {})
  end
  
  def urls(base, tmpfile)
    urls = []
    base = base.to_s
    doc = Hpricot(File.read(tmpfile.path))
    (doc / "a").each do |a| 
      begin
        if href = a.attributes["href"]
          urls << URI.join(base, href.strip)       
        end
      rescue Exception => e
        STDERR.puts "url error parsing URI.join(#{base.inspect}, #{href.inspect}): #{e.message}"
      end   
    end
    urls
  rescue Exception => e
    STDERR.puts "Couldn't parse #{base} for links: #{e.message}"
    nil
  end
end