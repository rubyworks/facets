require_relative './core/string/woot'

module A
  puts "Patched?".woot #> Patched? Woot!
end
