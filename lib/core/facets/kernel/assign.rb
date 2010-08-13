module Kernel

  # Assign via writer using arguments, hash or associative array.
  #
  # Using name-value arguments:
  #
  #   object = Object.new
  #
  #   object.assign(:a, 1)
  #   object.assign(:b, 2)
  #
  # Using a hash:
  #
  #   object.assign(:a => 1, :b => 2)
  #
  # Use an associative array:
  #
  #   object.assign([[:a, 1], [:b, 2]])
  #
  # These are all equivalent to:
  #
  #   object.a = 1 if object.respond_to?(:a=)
  #   object.b = 2 if object.respond_to?(:b=)
  #
  # Using an associative array instead of hash guarantees order of assignemnt
  # for older versions of Ruby (< 1.8.7).
  #
  # NOTE: This method used to allow a block which would yield on +self+.
  # This feature has been deprecated. There are plenty of other ways to
  # handle this, such as #tap.
  #
  # TODO: Should this be called #set instead? Consider Module#set in this
  # question, and also #set_from as the alias of #assign_from.

  def assign(data=nil, value=Exception) #:yield:
    if data
      if value==Exception
        data.each do |(k,v)|
          __send__("#{k}=", v) if respond_to?("#{k}=")
        end
      else
        __send__("#{data}=", value) if respond_to?("#{data}=")
      end
    end
    self
  end

  # DEPRECATED: Use #assign instead.
  #def populate(*a,&b)
  #  warn 'use #assign instead of #populate for future versions'
  #  assign(*a,&b)
  #end

  # Set attribute writers using like readers from another object.
  #
  #   class AssignExample
  #     attr_accessor :a, :b
  #     def initialize(a, b)
  #        @a, @b = a, b
  #     end
  #   end
  #
  #   obj1 = AssignExample.new(1,2)
  #   obj2 = AssignExample.new(3,4)
  #
  #   obj2.assign_from(obj1, :a, :b)
  #
  #   obj2.a  #=> 1
  #   obj2.b  #=> 2
  #
  # TODO: Should this be called #set_from ?

  def assign_from(obj, *fields)
    fields.each do |k|
      send("#{k}=", obj.__send__("#{k}"))  #if self.respond_to?("#{k}=") && obj.respond_to?("#{k}")
    end
  end

  # DEPRECATED: Original name for #assign_from.
  #alias_method :set_from, :assign_from
end

