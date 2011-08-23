require 'facets/denumerable'

module Enumerable

  # Without a block: wrap the Enumerable object in such a way that map,
  # select and similar operations are performed "horizontally" across a
  # series of blocks, instead of building an array of results at each step.
  # This reduces memory usage, allows partial results to be provided
  # early, and permits working with infinite series.
  #
  #   a = (1..1_000_000_000).defer.select{ |i| i % 2 == 0 }.
  #                                map{ |i| i + 100 }.
  #                                take(10).to_a
  #
  # With a block: the block acts as an arbitrary filter on the data. Unlike
  # map, it can choose to drop elements from the result, and/or add
  # additional ones. The first object passed to the block is the receiver
  # of the output.
  #
  #   (1..1_000_000_000).
  #     defer { |out,i| out << i if i % 2 == 0 }.  # like select
  #     defer { |out,i| out << i + 100 }.          # like map
  #     take(10).to_a
  #
  # Use a method like to_a or to_h at the end of the chain when you want an
  # Array or Hash built with the results, or each{...} if you just want
  # to output each result and discard it.
  #
  def defer(&blk)
    if block_given?
      Denumerator.new do |output|
        each do |*input|
          yield(output, *input)
        end
      end
    else
      Denumerator.new do |output|
        each do |*input|
          output.yield(*input)
        end
      end
    end
  end

end


=begin
  
  TODO: (Programming Challenge) Dynamically create this in a single
  method using a Functor and without the need of Denumerable.
  
  Below is my first shot at it. It's close, but it cannot handle
  infinite series.
 
  require 'facets/functor'

  def defer
    l = lambda do |enum|
      Functor.new do |op, *a, &b|
        case op.to_s
        when /^(to_|each)/
          enum.__send__(op, *a, &b)
        else
          l[enum.__send__(op, *a, &b)]
        end
      end
    end
    l[self]
  end

=end

