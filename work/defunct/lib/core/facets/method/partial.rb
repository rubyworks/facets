require 'facets/proc/partial'

class Method
  # Convert a method into a new partial Proc.

  def partial(*args)
    to_proc.partial(*args)
  end
end

