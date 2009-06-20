require "rubygems"
require "hpricot"
require "libxml"
require "zlib"
require "uri"
class RWGet::SitemapLinks
  def initialize(options = {})
  end
  
  def urls(base, tmpfile)
    type = `file -z "#{tmpfile.path}"`
    return []                                 unless type =~ /XML/i
    tmpfile = Zlib::GzipReader.new(tmpfile)   if type =~ /gzip/i
    
    doc = LibXML::XML::Reader.io(tmpfile)
    urls = []
    while doc.read
      next unless doc.node_type == 1 #element
      begin
        urls << URI.parse(doc.node.content) if doc.name == "loc"
      rescue 
        STDERR.puts "Skipping #{doc.node.to_s}"
      end
    end
    urls
  end
end