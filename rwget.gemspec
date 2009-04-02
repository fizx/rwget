Gem::Specification.new do |s|
  s.name     = "rwget"
  s.bindir   = "bin"
  s.executables = 'rwget'
  s.version  = "0.3.0"
  s.date     = "2009-04-01"
  s.summary  = "rwget"
  s.email    = "kyle@kylemaxwell.com"
  s.homepage = "http://kylemaxwell.com"
  s.description = "Wget, in ruby"
  s.has_rdoc = false
  s.files    = %w[
    bin/rwget
    lib/rwget/controller.rb
    lib/rwget/dupes.rb
    lib/rwget/fetch.rb
    lib/rwget/links.rb
    lib/rwget/queue.rb
    lib/rwget/rwget_option_parser.rb
    lib/rwget/store.rb
    lib/rwget.rb
    README.markdown
    Rakefile
    rwget.gemspec
    test/controller_test.rb
    test/dupes_test.rb
    test/fetch_test.rb
    test/links_test.rb
    test/queue_test.rb
    test/server.rb
    test/store_test.rb    
    ]
  s.add_dependency("curb", ["> 0.0.0"])
  s.add_dependency("hpricot", ["> 0.0.0", "< 0.7"])
  s.add_dependency("fizx-robots", [">= 0.3.1"])
  s.add_dependency("bloomfilter", ["> 0.0.0"])
  s.add_dependency("RubyInline", ["> 0.0.0"])
end