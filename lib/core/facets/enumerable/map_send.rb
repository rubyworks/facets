module Enumerable

  # Send a message to each element and collect the result.
  #
  #   [1,2,3].map_send(:+, 3)  #=> [4,5,6]
  #
  # CREDIT: Sean O'Halpin

  def map_send(meth, *args, &block)
    map{|e| e.send(meth, *args, &block)}
  end

  #--
  # Old defintion confused me ...
  #
  #   def map_send(meth, *args) #:yield:
  #     if block_given?
  #       map{|e| yield(e.send(meth, *args))}
  #     else
  #       map{|e| e.send(meth, *args)}
  #     end
  #   end
  #++

end

