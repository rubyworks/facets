require 'facets/memoizable'

class Module

  # This is here for backward compatibility.
  def memoize(*args)
    include Memoizable
    super(*args)
  end

end
