Gem::Specification.new do |s|
  s.name     = "rwget"
  s.bindir   = "bin"
  s.executables = 'rwget'
  s.version  = "0.2.2"
  s.date     = "2008-04-24"
  s.summary  = "rwget"
  s.email    = "kyle@kylemaxwell.com"
  s.homepage = "http://kylemaxwell.com"
  s.description = "Wget, in ruby"
  s.has_rdoc = false
  s.files    = Dir["**/*"]
  s.add_dependency("curb", ["> 0.0.0"])
  s.add_dependency("hpricot", ["> 0.0.0", "< 0.7"])
  s.add_dependency("fizx-robots", [">= 0.3.1"])
  s.add_dependency("bloomfilter", ["> 0.0.0"])
  s.add_dependency("RubyInline", ["> 0.0.0"])
end