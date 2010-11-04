dir, base = *File.split(__FILE__)
base = base.chomp('.rb')
Dir[File.join(dir, base, '*.rb')].each do |lib|
  require "facets/#{base}/#{File.basename(lib)}"
end

