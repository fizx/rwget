require "test/unit"
require File.dirname(__FILE__) + "/../lib/rwget"

class DupesTest < Test::Unit::TestCase
  def setup
    @dupes = RWGet::Dupes.new
  end
  
  def teardown
  end
  
  def test_links
    assert !@dupes.dupe?("uri")
    assert @dupes.dupe?("uri")
    assert !@dupes.dupe?("uri2")
  end
  
end