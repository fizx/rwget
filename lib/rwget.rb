module RWGet
end
Dir[File.dirname(__FILE__) + "/rwget/*.rb"].each do |f|
  require f.gsub(/\.rb$/, '')
end