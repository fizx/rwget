require "test/unit"
require File.dirname(__FILE__) + "/../lib/rwget"

class SitemapLinksTest < Test::Unit::TestCase
  def setup
    @links = RWGet::SitemapLinks.new
    @base = URI.parse("http://eventbrite.com")
    @index = File.open(File.dirname(__FILE__) + "/fixtures/sitemap_index.xml")
    @individual = File.open(File.dirname(__FILE__) + "/fixtures/events00.xml.gz")
    @html = File.open(File.dirname(__FILE__) + "/fixtures/yelp.html")
  end
  
  def test_links
    assert_equal 18, @links.urls(@base, @index).length
    assert_equal 39998, @links.urls(@base, @individual).length
    assert_equal 0, @links.urls(@base, @html).length
  end
end