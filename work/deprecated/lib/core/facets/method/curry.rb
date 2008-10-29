require 'facets/proc'

class Method
  # Curry a Method into a new Proc.

  def curry(*args)
    to_proc.curry(*args)
  end
end

