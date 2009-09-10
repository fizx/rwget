require "rubygems"
require "tempfile"
require "bloomfilter"

class RWGet::Dupes  
  SIZE = 1_000_000
  
  def initialize(options = {})
    @bloom = BloomFilter.new(SIZE, 4, 1)
  end
  
  def dupe?(uri)
    key = uri.to_s
    return true if @bloom.include?(key)
    @bloom.insert(key)
    return false
  end
end