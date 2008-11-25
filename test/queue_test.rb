require "test/unit"
require File.dirname(__FILE__) + "/server"
require File.dirname(__FILE__) + "/../lib/rwget"

class FetchTest < Test::Unit::TestCase
  def setup
    @queue = RWGet::Queue.new
  end
  
  def teardown
  end
  
  def test_put_get
    @queue.put("key", 1)
    assert_equal(["key", 1], @queue.get)
    assert_nil @queue.get
  end
  
end