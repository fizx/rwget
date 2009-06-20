# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rwget}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Maxwell"]
  s.date = %q{2009-06-19}
  s.default_executable = %q{rwget}
  s.email = %q{kyle@kylemaxwell.com}
  s.executables = ["rwget"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "bin/rwget",
     "lib/rwget.rb",
     "lib/rwget/controller.rb",
     "lib/rwget/dupes.rb",
     "lib/rwget/fetch.rb",
     "lib/rwget/links.rb",
     "lib/rwget/queue.rb",
     "lib/rwget/rwget_option_parser.rb",
     "lib/rwget/sitemap_links.rb",
     "lib/rwget/store.rb",
     "rwget.gemspec",
     "test/controller_test.rb",
     "test/dupes_test.rb",
     "test/fetch_test.rb",
     "test/fixtures/events00.xml.gz",
     "test/fixtures/sitemap_index.xml",
     "test/fixtures/yelp.html",
     "test/links_test.rb",
     "test/queue_test.rb",
     "test/server.rb",
     "test/sitemap_links_test.rb",
     "test/store_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/fizx/rwget}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Ruby port of wget, emphasis on recursive/crawler}
  s.test_files = [
    "test/controller_test.rb",
     "test/dupes_test.rb",
     "test/fetch_test.rb",
     "test/links_test.rb",
     "test/queue_test.rb",
     "test/server.rb",
     "test/sitemap_links_test.rb",
     "test/store_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<curb>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<hpricot>, ["> 0.0.0", "< 0.7"])
      s.add_runtime_dependency(%q<fizx-robots>, [">= 0.3.1"])
      s.add_runtime_dependency(%q<bloomfilter>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<libxml-ruby>, ["> 0.9"])
    else
      s.add_dependency(%q<curb>, ["> 0.0.0"])
      s.add_dependency(%q<hpricot>, ["> 0.0.0", "< 0.7"])
      s.add_dependency(%q<fizx-robots>, [">= 0.3.1"])
      s.add_dependency(%q<bloomfilter>, ["> 0.0.0"])
      s.add_dependency(%q<libxml-ruby>, ["> 0.9"])
    end
  else
    s.add_dependency(%q<curb>, ["> 0.0.0"])
    s.add_dependency(%q<hpricot>, ["> 0.0.0", "< 0.7"])
    s.add_dependency(%q<fizx-robots>, [">= 0.3.1"])
    s.add_dependency(%q<bloomfilter>, ["> 0.0.0"])
    s.add_dependency(%q<libxml-ruby>, ["> 0.9"])
  end
end
