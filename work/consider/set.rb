module Kernel

  # Assign via accessor methods using a varierty of arguments
  # including hash, associative array and/or block.
  # 
  # Examples:
  #
  #   object.set :a, 1
  #   object.set :b, 2
  # 
  #   object.set :a => 1, :b => 2
  #
  #   object.set [[:a, 1], [:b, 2]]
  #
  #   object.set do |s|
  #     s.a = 1
  #     s.b = 2
  #   end
  #
  # These example are all equivalent to:
  #
  #   object.a = 1
  #   object.b = 2
  #
  # Not that using an associative array instead of a hash
  # guarantees order of assignment.
  #
  # Using set's arugments, this method will not raise an error 
  # if the writer method does not exist --it will simply be
  # skipped. This is unlike Module#set which will create a
  # new accessor on demand. The block notation will still
  # raise an error however.
  #
  def set(data=nil, value=Exception) #:yield:
    if value != Exception
      __send__("#{data}=", value) if respond_to?("#{data}=")
    elsif data
      data.each do |k,v|
        __send__("#{k}=", v) if respond_to?("#{k}=")
      end
    end
    yield(self) if block_given?
    self
  end

end

