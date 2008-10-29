require 'facets/module/module_require'

module StringExtensions
end

printer = "hello world"

StringExtensions::String = class << printer; self; end

module StringExtensions
  module_require '~/ruby/facets/trunk/lib/core/ext/facets/string/titlecase.rb'
end

#printer.extend StringExtensions

puts printer.titlecase

