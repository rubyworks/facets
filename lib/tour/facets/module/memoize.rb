require 'facets/memoizable'

class Module

  # This is here for backward compatibility.
  def memoize(*args)
    include Memoizable
    Memoizable.instance_method(:memoize).bind(self).call(*args)
    #super(*args)  # TODO: why is super not working here?
  end

end
