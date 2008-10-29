# Dynamically load all core libraries.

__DIR__ = File.dirname(__FILE__)

list = []
Dir.chdir("#{__DIR__}/facets") do
  list = Dir['*']
end

list.each{ |f| require "facets/#{f}" }

