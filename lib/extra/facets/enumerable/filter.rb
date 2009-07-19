require 'facets/enumerable/take'
require 'facets/enumerator'

module Enumerable

  # Without a block: wrap the Enumerable object in such a way that map,
  # select and similar operations are performed "horizontally" across a
  # series of blocks, instead of building an array of results at each step.
  # This reduces memory usage, allows partial results to be provided
  # early, and permits working with infinite series.
  #
  #   (1..1_000_000_000).filter.select{ |i| i % 2 == 0 }.
  #                             map{ |i| i + 100 }.
  #                             take(10).to_a
  #
  # With a block: the block acts as an arbitrary filter on the data. Unlike
  # map, it can choose to drop elements from the result, and/or add
  # additional ones. The first object passed to the block is the receiver
  # of the output.
  #
  #   (1..1_000_000_000).
  #     filter { |out,i| out << i if i % 2 == 0 }.  # like select
  #     filter { |out,i| out << i + 100 }.          # like map
  #     take(10).each { |i| puts i }
  #
  # Use a method like to_a or to_h at the end of the chain if you want an
  # Array or Hash built with the results, or each { ... } if you just want
  # to output each result and discard it.
  #
  def filter(&blk)
    if block_given?
      Enumerator::Filter.new do |output|
        each do |*input|
          yield output, *input
        end
      end
    else
      Enumerator::Filter.new do |output|
        each do |*input|
          output.yield *input
        end
      end
    end
  end

  # = Filterable
  #
  # Classes which include Enumerable::Filterable will get versions
  # of map, select etc. which return a Filter, so that they work
  # horizontally without creating intermediate arrays.
  #
  module Filterable
    def map
      Enumerator::Filter.new do |output|
        each do |*input|
          output.yield yield(*input)
        end
      end
    end
    alias :collect :map

    def select
      Enumerator::Filter.new do |output|
        each do |*input|
          output.yield(*input) if yield(*input)
        end
      end
    end
    alias :find_all :select

    def reject
      Enumerator::Filter.new do |output|
        each do |*input|
          output.yield(*input) unless yield(*input)
        end
      end
    end

    # Limit to the first n items in the list

    def take(n)
      Enumerator::Filter.new do |output|
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
      Enumerator::Filter.new do |output|
        count = 0
        each do |*input|
          output.yield(*input) if count >= n
          count += 1
        end
      end
    end

    # TODO: add more methods, e.g. grep, take_while etc.
  end

end # module Enumerable


class Enumerator

  # = Enumerator::Filter
  #
  # A class like Enumerator, but which has 'lazy' versions of map, select etc.
  #
  class Filter < Enumerator
    include Enumerable::Filterable
  end

end

