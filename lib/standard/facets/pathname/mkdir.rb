class Pathname
  # Only calls mkdir if path doesn't already exist
  #
  # Credit: Ryan Duryea
  def mkdir?
    mkdir unless exist?
  end
end

