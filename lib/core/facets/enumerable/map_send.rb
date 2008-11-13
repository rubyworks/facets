module Enumerable

  # Send a message to each element and collect the result.
  #
  # CREDIT: Sean O'Halpin

  def map_send(meth, *args, &block)
    map{|e| e.send(meth, *args, &block)}
  end

  # Send a message to each element and collect the result.
  #
  # CREDIT: Sean O'Halpin
  #
  #def map_send(meth, *args) #:yield:
  #  if block_given?
  #    map{|e| yield(e.send(meth, *args))}
  #  else
  #    map{|e| e.send(meth, *args)}
  #  end
  #end

end

