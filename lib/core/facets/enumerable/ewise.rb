require 'facets/functor'

module Enumerable

  # Returns an elementwise Functor designed to make R-like
  # elementwise operations possible.
  #
  #   [1,2].elementwise + 3          #=> [4,5]
  #   [1,2].elementwise + [4,5]      #=> [5,7]
  #   [1,2].elementwise + [[4,5],3]  #=> [[5,7],[4,5]
  #
  #--
  # Special thanks to Martin DeMello for helping to develop this.
  #++

  def elementwise(count=1)
    @_elementwise_functor ||= []
    @_elementwise_functor[count] ||= Functor.new do |op,*args|
      if args.empty?
        r = self
        count.times do
          r = r.collect{ |a| a.send(op) }
        end
        r
      else
        r = args.collect do |arg|
          if Array === arg #arg.kind_of?(Enumerable)
            x = self
            count.times do
              ln = (arg.length > length ? length : arg.length )
              x = x.slice(0...ln).zip(arg[0...ln]).collect{ |a,b| a.send(op,b) }
              #slice(0...ln).zip(arg[0...1n]).collect{ |a,b| b ? a.send(op,b) : nil }
            end
            x
          else
            x = self
            count.times do
              x = x.collect{ |a| a.send(op,arg) }
            end
            x
          end
        end
        r.flatten! if args.length == 1
        r
      end
    end
  end

  # Concise alias for #elementwise.
  #
  #   a = [1,2]
  #   a.ewise + 3          #=> [4,5]
  #   a.ewise + [4,5]      #=> [5,7]
  #   a.ewise + [[4,5],3]  #=> [[5,7],[4,5]
  #
  # Note this used to be #ew as weel as the '%' operator.
  # Both of whihc are deprecated.

  alias_method :ewise, :elementwise

end
