require "rubygems"
require "tempfile"
require "bloomfilter"

class RWGet::Dupes  
  SIZE = 1_000_000
  
  def initialize(options = {})
    @tmp = Tempfile.new("bloom")
    @bloom = ExternalBloomFilter.create(@tmp.path, SIZE)
  end
  
  def dupe?(uri)
    key = uri.to_s
    return true if @bloom.include?(key)
    @bloom.add(key)
    return false
  end
end