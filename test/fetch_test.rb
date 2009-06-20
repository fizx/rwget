require "test/unit"
require File.dirname(__FILE__) + "/server"
require File.dirname(__FILE__) + "/../lib/rwget"

class FetchTest < Test::Unit::TestCase

  def test_fetch_success
    uri = URI.parse "#{$webroot}/foo/bar"
    final_url, file = RWGet::Fetch.new.fetch(uri, @user_agent)
    assert_equal uri, URI.parse(final_url)
    assert_kind_of Tempfile, file
    assert file.read =~ /<body>/i
  end
  
  def test_fetch_fail
    uri = URI.parse "http://a/b/b"
    assert_nil RWGet::Fetch.new.fetch(uri, @user_agent)
  end
end