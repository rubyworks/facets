dir = File.dirname(__FILE__) + '/facets/'
Dir.new(dir).each do |path|
  next unless File.extname(path) == '.rb'
  require('facets/' + path)  #require(dir + path)
end

