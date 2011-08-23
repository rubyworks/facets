# Require all Process core extensions.

if RUBY_VERSION < '1.9'
  require "facets/process/daemon.rb"
else
  require_relative "process/daemon.rb"
end

