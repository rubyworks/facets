# BALCK MAJIC


__END__


class Class

  # query langauge for the ruby object model

  def defn(name, &procedure)
    define_method(name, &procedure
  end

end

def Class(name, &initialize)
  const_set(name.capitalize, Class.new(&initialize))
end

 Class(HelloWorld) do%{
     attr(:msg).default("")
     defn(:sayit) {
       puts("Hello World")
     }
   }end




# WE PROGRAM BACKWARDS

1. class(name).method(name)




class ObjectX
  def initialize(a, h, &b)
    attributes = h
    elements = a
    body = b
  end

  def

  def +(x)
    case type, x.type
    when [:integer, :integer]
      ObjectX.new(:integer, elements[0] + x.elements[0])
    when [:string, :string]
      x.attributes
    when
  end

  def <<()

end

class NilClass

  def object(*a, &b)
    h = a.last.is_a?(Hash) ? a.pop : {}
    ObjectX.new(a, h, &b)
  end

  def array(*a)
    a
  end

  def hash(hash_or_array)
    case hash_or_array
    when Array
      Hash[*hash_or_array]
    when Hash
      hash_or_array.dup
    else

    end
  end

  def string(*a, &b)
    String.new(*a, &b)
  end



  def array1(*a, &b)
    Array.new(*a, &b)
  end

  def hash1(*a, &b)
    Hash.new(*a, &b)
  end

  def string1(*a, &b)
    String.new(*a, &b)
  end

end


array(1,2,3)
