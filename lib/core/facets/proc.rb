# Require all Proc core extensions.

if RUBY_VERSION < '1.9'
  require "facets/proc/bind.rb"
  require "facets/proc/bind_to.rb"
  require "facets/proc/compose.rb"
  require "facets/proc/curry.rb"
  require "facets/proc/partial.rb"
  require "facets/proc/to_method.rb"
  require "facets/proc/update.rb"
else
  require_relative "proc/bind.rb"
  require_relative "proc/bind_to.rb"
  require_relative "proc/compose.rb"
  require_relative "proc/curry.rb"
  require_relative "proc/partial.rb"
  require_relative "proc/to_method.rb"
  require_relative "proc/update.rb"
end

