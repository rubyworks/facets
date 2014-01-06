class Array

  # Store a value at a given index. Store is an alias for #[]=.
  #
  # Example:
  #
  #   a = []
  #   a.store(1, "A")
  #   a[1] #=> "A"
  #
  # Returns the stored object.

  alias_method :store, :[]=

end

