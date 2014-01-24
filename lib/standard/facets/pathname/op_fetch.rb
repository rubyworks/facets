class Pathname

  # Alternate to Pathname#new.
  #
  #   Pathname['/usr/share']
  #
  # Returns [Pathname]

  def self.[](path)
    new(path)
  end

end
