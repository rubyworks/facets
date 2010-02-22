module Enumerable

  # The block acts as an arbitrary filter on the data. Unlike map,
  # it can choose to drop elements from the result and/or add
  # additional elements. The first object passed to the block is
  # the receiver of the output.
  #
  #   (1..1_000_000_000).
  #     filter{ |out,i| out << i if i % 2 == 0 }.  # like select
  #     filter{ |out,i| out << i + 100 }.          # like map
  #     take(10).each{ |i| puts i }
  #
  # This is very similar to #each_with_object, but #filter handles
  # argument better by reversing their order and using the splat
  # operator.

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

  # OLD NAME
  # CREDIT: David Black, Louis J Scoras
  #def injecting(k)
  #  each{ |i| yield(k, i) }; k
  #end

end

