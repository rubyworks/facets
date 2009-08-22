require 'facets/functor'

module Enumerable

  # Wrap the Enumerable object in such a way that map, select and
  # similar operations are performed "horizontally" across a series
  # of blocks, instead of building an array of results at each step.
  # This reduces memory usage, allows partial results to be provided
  # early, and permits working with infinite series.
  #
  #   (1..1_000_000_000).defer.select{ |i| i % 2 == 0 }.
  #                            map{ |i| i + 100 }.
  #                            take(10).to_a
  #
  # Use a method like to_a or to_h at the end of the chain if you want an
  # Array or Hash built with the results, or each{ ... } if you just want
  # to output each result and discard it.
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

end


=begin test.ae

  r = (1..10).defer.select{ |i| i % 2 == 0 }.map{ |i| i + 100 }.to_a
  r.assert == [102,104,106,108,110]

=end

