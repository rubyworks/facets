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
      raise IndexError, "not the only element of array"
    end
    first
  end

  # Does this Array have only one element?
  # 
  # TODO: While clearly this goes along with the regular #only method,
  # the name doesn't seem quite right. Perhaps rename to #lonely.
  #
  # CREDIT: Lavir the Whiolet
  #
  def only?
    size == 1
  end
 
end

