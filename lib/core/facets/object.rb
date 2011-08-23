# Require all Object core extensions.

if RUBY_VERSION < '1.9'
  require "facets/object/clone.rb"
  require "facets/object/dup.rb"
  require "facets/object/object_state.rb"
  require "facets/object/replace.rb"
  require "facets/object/try_dup.rb"
else
  require_relative "object/clone.rb"
  require_relative "object/dup.rb"
  require_relative "object/object_state.rb"
  require_relative "object/replace.rb"
  require_relative "object/try_dup.rb"
end

