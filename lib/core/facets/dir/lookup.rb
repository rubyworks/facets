class Dir

  # Lookup directory tree for a path.
  #
  # TODO: Make a non class method version of this?
  #
  # Returns full path or `nil` if not found. [String,nil]

  def self.lookup(rel_path, parent_path='.')
    while true
      path = File.expand_path(rel_path, parent_path)

      return path if File.exists?(path)
      return nil if path == '/'

      parent_path = File.expand_path('..', parent_path)
    end
  end

end
