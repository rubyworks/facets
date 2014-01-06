require 'facets/functor'

class Enumerator

  # TODO: Should Enumerator#fx be moved to functor gem?

  #
  def fx
    Functor.new do |op, *a, &b|
      map{ |e| e.send(op, *a, &b) }
    end
  end

#  Old 1.8 version (left temporarily for reference)
#
#  def fx
#    Functor.new(&method(:fx_send).to_proc)
#  end
#
#  private
#
#  def fx_send(op, *a, &b)
#    map{ |e| e.send(op, *a, &b) }
#  end

end

