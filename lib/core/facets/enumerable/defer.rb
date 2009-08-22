require 'facets/enumerable/take'
require 'facets/enumerator'

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
  #     take(10).
  #     each { |i| puts i }
  #
  # Using with a block, defer(&b), is equivalent to:
  #
  #   defer.filter(&b)
  #
  # Use a method like to_a or to_h at the end of the chain when you want an
  # Array or Hash built with the results, or each{...} if you just want
  # to output each result and discard it.
  #
  def defer(&blk)
    if block_given?
      Denumerator.new do |output|
        each do |*input|
          yield output, *input
        end
      end
    else
      Denumerator.new do |output|
        each do |*input|
          output.yield *input
        end
      end
    end
  end

=begin
  require 'facets/functor'
  #
  # TODO: (Programming Challenge) Dynamically create this in a single
  # method using a Functor and without the need of Denumerable.
  #
  # Below is my first shot at it. It's close, but it cannot handle
  # infinite series.
  #
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

end


# = Denumerable
#
# Classes which include Enumerable::Filterable will get versions
# of map, select etc. which return a Filter, so that they work
# horizontally without creating intermediate arrays.
#
module Denumerable

  #
  def map
    Denumerator.new do |output|
      each do |*input|
        output.yield yield(*input)
      end
    end
  end
  alias :collect :map

  #
  def select
    Denumerator.new do |output|
      each do |*input|
        output.yield(*input) if yield(*input)
      end
    end
  end
  alias :find_all :select

  #
  def reject
    Denumerator.new do |output|
      each do |*input|
        output.yield(*input) unless yield(*input)
      end
    end
  end

  # Limit to the first n items in the list
  def take(n)
    Denumerator.new do |output|
      count = 0
      each do |*input|
        break if count >= n
        output.yield(*input)
        count += 1
      end
    end
  end

  # Skip the first n items in the list
  def skip(n)
    Denumerator.new do |output|
      count = 0
      each do |*input|
        output.yield(*input) if count >= n
        count += 1
      end
    end
  end

  # TODO: add more methods, e.g. grep, take_while etc.
end

# = Denumerator
#
# A class like Enumerator, but which has 'lazy' versions of map, select etc.
#
class Denumerator < Enumerator
  include Denumerable
end


=begin test.ae

  r = (1..10).defer.select{ |i| i % 2 == 0 }.map{ |i| i + 100 }.to_a
  r.assert == [102,104,106,108,110]

=end

