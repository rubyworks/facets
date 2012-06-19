require 'facets/proc'

class Method
  # Curry a Method into a new Proc.

  def curry(*args)
    to_proc.curry(*args)
  end
end


# TODO: The question is as to whether to integrate this into Method::Composition,
# or if Composition should be scuttled for just converting to Proc.
