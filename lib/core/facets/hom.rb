# HOM stands for Higher-Order-Message. Essentally, a HOM can vary
# its behavior accorrding to the operation applied to it.
#
#   f = HOM.new { |op, x| x.send(op, x) }
#   (f + 1)  #=> 2
#   (f + 2)  #=> 4
#   (f + 3)  #=> 6
#   (f * 1)  #=> 1
#   (f * 2)  #=> 4
#   (f * 3)  #=> 9
#
class HOM #< BasicObject

  # HOMs can be somewhat inefficient if a new HOM
  # is frequently recreated for the same use. So this cache
  # can be used to speed things up.
  #
  # The +key+ will always be an array, wich makes it easier
  # to cache HOM for multiple factors.
  #
  def self.cache(*key, &function)
    @cache ||= {}
    if function
      @cache[key] = new(&function)
    else
      @cache[key]
    end
  end

  EXCEPTIONS = [:binding, :inspect, :object_id]
  if defined?(::BasicObject)
    EXCEPTIONS.concat(::BasicObject.instance_methods)
    EXCEPTIONS.uniq!
    EXCEPTIONS.map!{ |m| m.to_sym }
  end

  #
  alias :__class__ :class

  ## If HOM were built-in to Ruby this would not be
  ## needed since exceetions could just be added directly.
  ##$HOM_EXCEPTIONS ||= [:binding, :undefine_method]

  ## TODO: This will not work when BasicObject is utilized. How to fix?
  ##def self.honor_exceptions
  ##  $HOM_EXCEPTIONS.each{ |name|
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
  ##  #"#<#{__class__}:#{object_id} #{method_missing(:inspect)}>"    # hex id ?
  ##  "#{method_missing(:inspect)}"
  ##end

  ## Needed?
  ##def send(op, *a, &b)
  ##  method_missing(op, *a, &b)
  ##end

  private

  # Any action against the HOM is processesd by the function.
  def method_missing(op, *args, &blk)
    @function.call(op, *args, &blk)
  end

end
