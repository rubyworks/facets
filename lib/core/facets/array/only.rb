class Array

  # Returns the _only_ element in the array.  Raises an IndexError if
  # the array's size is not 1.
  #
  #   [5].only      # => 5
  #
  #   expect IndexError do
  #     [1,2,3].only
  #   end
  #
  #   expect IndexError do
  #     [].only
  #   end
  #
  # CREDIT: Gavin Sinclair, Noah Gibbs

  def only
    unless size == 1
      raise IndexError, "Array#only called on non-single-element array"
    end
    first
  end

end

