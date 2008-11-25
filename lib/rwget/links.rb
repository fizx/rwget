require "rubygems"
require "hpricot"
class RWGet::Links
  def urls(base, tmpfile)
    urls = []
    doc = Hpricot(File.read(tmpfile.path))
    (doc / "a").map {|a| a.attributes["href"]}.compact.map{|p| URI.join(base.to_s, p) }
  rescue Exception => e
    STDERR.puts "Couldn't parse #{base} for links: #{e.message}"
    nil
  end
end