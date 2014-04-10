require 'facets/functor'

class Object

  # Objectified message or block application. Only a message
  # or a block can be given, not both.
  #
  # msg - method and arguments [Array]
  # blk - procedure block [Proc]
  #
  # Examples
  #
  #   a = [1,2,3,4,5]
  #   c = a.against(:>, 2)
  #   c.select  #=> [3,4,5]
  #
  #   a = [1,2,3,4,5]
  #   c = a.against(:>)
  #   c.select(2)  #=> [3,4,5]
  #
  # Returns [Functor]
  #
  # TODO: Better name for this method?

  def against(*msg, &blk)
    raise ArgumentError, "too many arguments" if blk && !msg.empty?

	  this = self

    blk = ::Proc.new{ |x,*a| x.__send__(*msg, *a) } unless blk

    #if blk
		  Functor.new do |m, *a, &b|
			  if b
			    b2 = ::Proc.new{ |*x| blk.call(*b.call(*x), *a) }
        else
          b2 = blk
			  end
			  this.__send__(m, &b2)
		  end
    #else
	  #	Functor.new do |m, *a, &b|
	  #		if b
	  #		  b2 = ::Proc.new{ |*x| b.call(*x).__send__(*msg, *a) }
	  #		else
	  #		  b2 = ::Proc.new{ |x| x.__send__(*msg, *a) }
	  #		end
	  #		this.__send__(m, &b2)
	  #	end
    #end
  end

end
