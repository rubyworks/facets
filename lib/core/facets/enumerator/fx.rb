require 'facets/functor'

class Enumerator

  # TODO: Should Enumerator#fx be moved to functor gem?

  #
  def fx
    Functor.new do |op, *a, &b|
      map{ |e| e.send(op, *a, &b) }
    end
  end

end
