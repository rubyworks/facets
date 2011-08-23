# Load all Dir core extensions.

if RUBY_VERSION < '1.9'
  require "facets/dir/ascend.rb"
  require "facets/dir/descend.rb"
  require "facets/dir/each_child.rb"
  require "facets/dir/multiglob.rb"
  require "facets/dir/parent.rb"
  require "facets/dir/recurse.rb"
else
  require_relative "dir/ascend.rb"
  require_relative "dir/descend.rb"
  require_relative "dir/each_child.rb"
  require_relative "dir/multiglob.rb"
  require_relative "dir/parent.rb"
  require_relative "dir/recurse.rb"
end

