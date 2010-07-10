module Enumerable

  # The block acts as an arbitrary filter on the data. Unlike map,
  # it can choose to drop elements from the result and/or add
  # additional elements. The first object passed to the block is
  # the receiver of the output.
  #
  #   x = (1..10000)
  #   x = x.filter{ |out,i| out << i if i % 2 == 0 }   # like select
  #   x = x.filter{ |out,i| out << i + 100 }           # like map
  #   x = x.take(3)
  #
  #   x  #=> [102, 104, 106]
  #
  # This is very similar to #each_with_object, but #filter handles
  # argument better by reversing their order and using the splat
  # operator. (This was also once known as #injecting.)
  #
  # CREDIT: David Black, Louis J Scoras

  def filter(output=[]) #:yeild:
    if block_given?
      each do |*input|
        yield(output, *input)
      end
      output
    else
      to_enum(:filter)
    end
  end

end

