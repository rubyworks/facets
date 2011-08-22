class Array

  # Store a value at a given index. Store is an alias for #[]=.
  #
  #   a = []
  #   a.store(1, "A")
  #   a[1] #=> "A"
  #
  alias_method :store, :[]=

end

