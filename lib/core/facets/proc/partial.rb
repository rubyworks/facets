class Proc

  # Convert a Proc object into new partial Proc object.
  #
  #   a = proc { |a,b,c| a+b+c }
  #   b = a.partial(X,2,X)
  #   b[1,3] #=> 6
  #
  #   a = proc { |a,b,c| a+b+c }
  #   b = a.partial(__,2,__)
  #   b[1,3] #=> 6
  #
  # This method is similar to Proc#curry.
  #
  # CREDT Trans

  def partial(*args)
    Proc.new do |*spice|
      result = args.collect do |a|
        X == a ? spice.pop : a
      end
      call(*result)
    end
  end

end

# X class is used to represent an argument "slot".

class X < ArgumentError #:nodoc:
end

# Convenience method for an argument slot.
# It simple returns the X exception class.

def __
  X
end

