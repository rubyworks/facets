# MissingArgument exception class is used to represent an argument "hole".

class MissingArgument < ArgumentError
end

# Convenience method for an argument hole.
# It simple returns the MissingArgument exception class.

def __
  MissingArgument
end

class Proc

  # Convert a Proc object into new partial Proc object.
  #
  #   a = proc { |a,b,c| a+b+c }
  #   b = a.partial(__, 2, __)
  #   b[1,3] #=> 6
  #
  # This method is similar to Proc#curry.
  #
  # CREDT Trans
  #
  # TODO: Parhaps ArgumentError would suffice, and we don't need MissingArgument?

  def partial(*args)
    Proc.new do |*spice|
      result = args.collect do |a|
        MissingArgument == a ? spice.pop : a
      end
      call(*result)
    end
  end

end

