class Pathname

  # Start a path. Another alias for #new.
  #
  #   Pathname / 'usr'
  #
  def self./(path)
    new(path)
  end

  # Try to get this into standard Pathname class.
  alias_method :/, :+

end

