require 'find'

class Dir

  # Recursively traverse a directory, yielding each file and directory path.
  # Supports Find.prune to skip subtrees.
  #
  #   Dir.find('.') do |path|
  #     puts path
  #   end
  #
  # Returns an enumerator if no block is given.
  #
  # This is a convenience wrapper around Ruby's Find.find.

  def self.find(*paths, ignore_error: true, &block)
    Find.find(*paths, ignore_error: ignore_error, &block)
  end

end
