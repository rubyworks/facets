class Method

  # Memoize a method by defining a singleton override.
  def memoize(value)
    singleton = (class << receiver; self; end)
    singleton.__send__(:define_method, name){ value }
  end

end

