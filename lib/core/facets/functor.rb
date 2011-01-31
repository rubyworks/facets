# By definition a Functor is simply a first class method, but these are common
# in the form of Method and Proc. So for Ruby a Functor is a more specialized
# as a Higher-order function or Metafunction. Essentally, a Functor can vary
# its behavior accorrding to the operation applied to it.
#
#   f = Functor.new { |op, x| x.send(op, x) }
#   (f + 1)  #=> 2
#   (f + 2)  #=> 4
#   (f + 3)  #=> 6
#   (f * 1)  #=> 1
#   (f * 2)  #=> 4
#   (f * 3)  #=> 9
#
class Functor #< BasicObject

  EXCEPTIONS = [:binding, :inspect, :object_id]
  if defined?(::BasicObject)
    EXCEPTIONS.concat(::BasicObject.instance_methods)
    EXCEPTIONS.uniq!
    EXCEPTIONS.map!{ |m| m.to_sym }
  end

  #
  alias :__class__ :class

  ## If Functor were built-in to Ruby this would not be
  ## needed since exceetions could just be added directly.
  ##$FUNCTOR_EXCEPTIONS ||= [:binding, :undefine_method]

  ## TODO: This will not work when BasicObject is utilized. How to fix?
  ##def self.honor_exceptions
  ##  $FUNCTOR_EXCEPTIONS.each{ |name|
  ##    next if method_defined?(name)
  ##    eval %{
  ##      def #{name}(*a,&b)
  ##        super(*a, &b)
  ##      end
  ##    }
  ##  }
  ##end

  # Privatize all methods except vital methods and #binding.
  instance_methods(true).each do |m|
    next if m.to_s =~ /^__/
    next if EXCEPTIONS.include?(m.to_sym)
    undef_method(m)
  end

  #
  def initialize(&function)
    @function = function
  end

  #
  def to_proc
    @function
  end

  ##def inspect
  ##  #"#<Functor:#{object_id} #{method_missing(:inspect)}>"    # hex id ?
  ##  "#{method_missing(:inspect)}"
  ##end

  ## Needed?
  ##def send(op, *a, &b)
  ##  method_missing(op, *a, &b)
  ##end

  private

  # Any action against the functor is processesd by the function.
  def method_missing(op, *args, &blk)
    @function.call(op, *args, &blk)
  end

end

# Copyright (c) 2004 Thomas Sawyer (Ruby License)
