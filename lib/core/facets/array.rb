path = __FILE__.chomp('.rb')
base = File.basename(path)
Dir[File.join(path, '*.rb')].each do |lib|
  #require lib # why is this so much slower?
  require "facets/#{base}/#{File.basename(lib)}"
end

