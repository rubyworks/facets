# Load all FileTest core extensions.

if RUBY_VERSION < '1.9'
  require "facets/filetest/absolute.rb"
  require "facets/filetest/contains.rb"
  require "facets/filetest/relative.rb"
  require "facets/filetest/root.rb"
  require "facets/filetest/safe.rb"
  require "facets/filetest/separator_pattern.rb"
else
  require_relative "filetest/absolute.rb"
  require_relative "filetest/contains.rb"
  require_relative "filetest/relative.rb"
  require_relative "filetest/root.rb"
  require_relative "filetest/safe.rb"
  require_relative "filetest/separator_pattern.rb"
end

