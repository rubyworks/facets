module Enumerable

  # Uses #+ to sum the enumerated elements.
  #
  #   [1,2,3].sum  #=> 6
  #   [3,3,3].sum  #=> 9
  #
  # @author Dawid Marcin Grzesiak (bug fix)

  def sum(identity=0, &block)
    if block_given?
      map(&block).sum(identity)
    else
      inject{ |sum, element| sum + element } || identity
    end
  end

end
