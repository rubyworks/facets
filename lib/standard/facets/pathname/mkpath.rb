class Pathname
  # Only calls mkpath if path doesn't already exist
  #
  # Credit: Ryan Duryea
  def mkpath?
    mkpath unless exist?
  end
end

