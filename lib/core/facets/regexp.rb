# Require all Regexp core extensions.

if RUBY_VERSION < '1.9'
  require "facets/regexp/arity.rb"
  require "facets/regexp/multiline.rb"
  require "facets/regexp/op_add.rb"
  require "facets/regexp/op_or.rb"
  require "facets/regexp/to_re.rb"
else
  require_relative "regexp/arity.rb"
  require_relative "regexp/multiline.rb"
  require_relative "regexp/op_add.rb"
  require_relative "regexp/op_or.rb"
  require_relative "regexp/to_re.rb"
end

