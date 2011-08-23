# Load all File core extensions.

if RUBY_VERSION < '1.9'
  require "facets/file/append.rb"
  require "facets/file/create.rb"
  require "facets/file/ext.rb"
  require "facets/file/null.rb"
  require "facets/file/read_binary.rb"
  require "facets/file/read_list.rb"
  require "facets/file/rewrite.rb"
  require "facets/file/rootname.rb"
  require "facets/file/sanitize.rb"
  require "facets/file/split_all.rb"
  require "facets/file/split_root.rb"
  require "facets/file/write.rb"
  require "facets/file/writelines.rb"
else
  require_relative "file/append.rb"
  require_relative "file/create.rb"
  require_relative "file/ext.rb"
  require_relative "file/null.rb"
  require_relative "file/read_binary.rb"
  require_relative "file/read_list.rb"
  require_relative "file/rewrite.rb"
  require_relative "file/rootname.rb"
  require_relative "file/sanitize.rb"
  require_relative "file/split_all.rb"
  require_relative "file/split_root.rb"
  require_relative "file/write.rb"
  require_relative "file/writelines.rb"
end

