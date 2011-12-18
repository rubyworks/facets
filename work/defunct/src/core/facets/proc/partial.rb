require 'facets/na'

class Proc

  # Convert a Proc object into new partial Proc object.
  #
  #   a = proc { |a,b,c| a+b+c }
  #   b = a.partial(NA,2,NA)
  #   b[1,3] #=> 6
  #
  # Note, the #__ method, which used to be used in stay of NA,
  # has been deprecated.
  #
  #--
  #   a = proc { |a,b,c| a+b+c }
  #   b = a.partial(__,2,__)
  #   b[1,3] #=> 6
  #++
  #
  # This method is similar to Proc#curry.
  #
  # CREDT Trans

  def partial(*args)
    Proc.new do |*spice|
      result = args.collect do |a|
        NA == a ? spice.pop : a
      end
      call(*result)
    end
  end

end
