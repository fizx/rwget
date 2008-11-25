require "test/unit"
require File.dirname(__FILE__) + "/server"
require File.dirname(__FILE__) + "/../lib/rwget"

class FetchTest < Test::Unit::TestCase
  include ::RWGet
  def setup
    @fetch = Fetch.new
    @user_agent = "hello"
  end
  
  def teardown
  end
  
  def test_fetch_success
    uri = URI.parse "#{$webroot}/foo/bar"
    file = @fetch.fetch(uri, @user_agent)
    assert_kind_of Tempfile, file
    assert file.read =~ /<body>/i
  end
  
  def test_fetch_fail
    uri = URI.parse "http://a/b/b"
    assert_nil @fetch.fetch(uri, @user_agent)
  end
end