require 'facets/functor'

module Enumerable

  # Returns an elementwise Functor designed to make R-like
  # elementwise operations possible. This is very much like
  # the #every method, but it treats array argument specially.
  #
  #   ([1,2].ewise + 3)          #=> [4,5]
  #
  # Vector to vector
  #
  #   ([1,2].ewise + [4,5])      #=> [5,7]
  #
  # Special thanks to Martin DeMello for helping to develop this.

  def ewise(count=1)
    Functor.new do |op,*args|
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
              x = x.slice(0...ln)
              x = x.zip(arg[0...ln])
              x = x.collect{ |a,b| a.send(op,b) }  #x = x.collect{ |a,b| b ? a.send(op,b) : nil }
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

  # Long-term for #ewise.
  #
  #   a = [1,2]
  #   (a.elementwise + 3)          #=> [4,5]
  #   (a.elementwise + [4,5])      #=> [5,7]
  #
  alias_method :elementwise, :ewise

end

