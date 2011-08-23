# Load all Class core extensions.

if RUBY_VERSION < '1.9'
  require "facets/class/descendants.rb"
  require "facets/class/methodize.rb"
  require "facets/class/pathize.rb"
  require "facets/class/subclasses.rb"
  require "facets/class/to_proc.rb"
else
  require_relative "class/descendants.rb"
  require_relative "class/methodize.rb"
  require_relative "class/pathize.rb"
  require_relative "class/subclasses.rb"
  require_relative "class/to_proc.rb"
end

