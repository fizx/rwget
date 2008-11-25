require "test/unit"
require File.dirname(__FILE__) + "/server"
require File.dirname(__FILE__) + "/../lib/rwget"
require "fileutils"

class ControllerTest < Test::Unit::TestCase
  include FileUtils
  def setup
    @tmp = File.dirname(__FILE__) + "/tmp"
    mkdir_p @tmp
    @options = {
      :prefix => @tmp 
    }
    @rwget = RWGet::Controller.new(@options)
  end
  
  def teardown
    rm_rf @tmp
  end
  
  def test_key_for
    assert_equal File.join(@tmp, "yahoo.com", "index.html"), @rwget.key_for(URI.parse("http://yahoo.com/"))
  end
end