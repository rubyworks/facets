require_relative 'refined_core/string/woot'

module A
  using RefinedCore::String::Woot
  puts "Refined?".woot # => Refined? Woot!
end

module B
  puts "Refined?".woot #=> NoMethodError ...undefined method `woot' for...
end
