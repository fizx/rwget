require "rubygems"
require "hpricot"
class RWGet::Links
  def initialize(options = {})
  end
  
  def urls(base, tmpfile)
    @urls = []
    base = base.to_s
    string = File.read(tmpfile.path)
    xml = string =~ /<\?xml/
    doc = xml ? Hpricot.XML(string) : Hpricot(string)
    
    (doc / "//item/link").each do |l|
      add base, l.inner_text
    end
    (doc / "a").each do |a| 
      add base, a.attributes["href"]
    end
    @urls
  rescue Exception => e
    STDERR.puts "Couldn't parse #{base} for links: #{e.message}"
    []
  end
  
  def add(base, href)
    begin
      @urls << URI.join(base, href.strip) if href
    rescue Exception => e
      STDERR.puts "url error parsing URI.join(#{base.inspect}, #{href.inspect}): #{e.message}"
    end
  end
end