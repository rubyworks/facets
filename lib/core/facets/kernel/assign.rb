module Kernel

  # Assign via writer using a arguments, hash or
  # associative array, and son on, or assign via 
  # a block.
  #
  # Using name-value arguments:
  #
  #   object.assign(:a, 1)
  #   object.assign(:b, 2)
  #
  # Using a hash:
  #
  #   object.assign( :a => 1, :b => 2 )
  #
  # Use an associative array:
  #
  #   object.assign( [[:a, 1], [:b, 2]] )
  #
  # Using a block:
  #
  #   object.assign do |s|
  #     s.a = 1
  #     s.b = 2
  #   end
  #
  # These are all equivalent to:
  #
  #   object.a = 1
  #   object.b = 2
  #
  # Unless assigned via a block, undefined setters will not
  # raise an error if they do not exist. They will simply be
  # skipped.
  #
  # Using an associative array instead of hash guarentees
  # order of assignemnt for older versions of Ruby (< 1.8.7).
  #
  # TODO: Should this be called #set instead?

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
    yield(self) if block_given?
    self
  end

  # DEPRECATE: Use #assign instead.
  def populate(*a,&b)
    warn 'use #assign instead of #populate for future versions'
    assign(*a,&b)
  end
end

