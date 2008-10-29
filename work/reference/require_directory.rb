dir  = __FILE__.chomp('.rb')
libs = Dir.glob(dir + '/*.rb')
libs.each{ |lib| require lib }

