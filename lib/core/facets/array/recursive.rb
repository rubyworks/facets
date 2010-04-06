require 'facets/functor'

class Array

  # Recursive functor (expiremental).
  #
  def recursive
    array = self
    Functor.new do |op, &b|
      array.__send__(op) do |e|
        if e.respond_to?(:to_ary)
          e.to_ary.recursive.__send__(op, &b)
        else
          b.call(e)
        end
      end
    end
  end

end
