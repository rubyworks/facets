# Require all Symbol core extensions.

if RUBY_VERSION < '1.9'
  require "facets/symbol/as_s.rb"
  require "facets/symbol/bang.rb"
  require "facets/symbol/chomp.rb"
  require "facets/symbol/generate.rb"
  require "facets/symbol/not.rb"
  require "facets/symbol/op_div.rb"
  require "facets/symbol/plain.rb"
  require "facets/symbol/query.rb"
  require "facets/symbol/setter.rb"
  require "facets/symbol/succ.rb"
  require "facets/symbol/thrown.rb"
  require "facets/symbol/to_proc.rb"
  require "facets/symbol/variablize.rb"
else
  require_relative "symbol/as_s.rb"
  require_relative "symbol/bang.rb"
  require_relative "symbol/chomp.rb"
  require_relative "symbol/generate.rb"
  require_relative "symbol/not.rb"
  require_relative "symbol/op_div.rb"
  require_relative "symbol/plain.rb"
  require_relative "symbol/query.rb"
  require_relative "symbol/setter.rb"
  require_relative "symbol/succ.rb"
  require_relative "symbol/thrown.rb"
  require_relative "symbol/to_proc.rb"
  require_relative "symbol/variablize.rb"
end

