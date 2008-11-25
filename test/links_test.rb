require "test/unit"
require File.dirname(__FILE__) + "/../lib/rwget"

class LinksTest < Test::Unit::TestCase
  def setup
    @t = Tempfile.new("testings")
    @t.puts <<-STR
    <html><body>fdssdfsad
      <a href="foo">boo</a></body></html>
    STR
    @t.close
    @links = RWGet::Links.new
  end
  
  def teardown
  end
  
  def test_links
    assert_equal [URI.parse("http://yahoo.com/foo/foo")], @links.urls(URI.parse("http://yahoo.com/foo/bar"), @t)
  end
  
end