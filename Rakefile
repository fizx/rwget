task :default => :test

task :test => :build do
  Dir["test/*test*.rb"].each {|f| load f }
end

task :install do 
  system "gem uninstall -Ix fizx-rwget"
  system "gem uninstall -Ix rwget"
  system "gem build rwget.gemspec"
  system "gem install rwget"
end