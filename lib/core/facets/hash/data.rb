require 'facets/functor'

class Hash

  # TODO: The name of this method may change.
  #
  def data
    Functor.new() do |op| 
      self[op]
    end
  end

end

