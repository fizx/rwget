require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rwget"
    gem.summary = %Q{Ruby port of wget, emphasis on recursive/crawler}
    gem.email = "kyle@kylemaxwell.com"
    gem.homepage = "http://github.com/fizx/rwget"
    gem.authors = ["Kyle Maxwell"]
    gem.add_dependency("curb", ["> 0.0.0"])
    gem.add_dependency("hpricot", ["> 0.0.0"])
    gem.add_dependency("fizx-robots", [">= 0.3.1"])
    gem.add_dependency("bloomfilter", ["> 0.0.0"])
    gem.add_dependency("libxml-ruby", ["> 0.9"])
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rwget #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

