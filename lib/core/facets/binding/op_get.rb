class Binding

  # Returns the value of a local variable.
  #
  #   a = 2
  #   binding[:a]  #=> 2
  #
  def [](name)
    local_variable_get(name.to_sym)
  end

  # Set the value of a local variable.
  #
  #   binding[:a] = 4
  #   a  #=> 4
  #
  def []=(name, value)
    local_variable_set(name.to_sym, value)
  end

end
