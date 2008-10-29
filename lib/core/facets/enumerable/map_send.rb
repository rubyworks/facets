module Enumerable

   # Send a message to each element and collect the result.
   #
   #  CREDIT: Sean O'Halpin

  def map_send(meth, *args, &block)
    map{|e| e.send(meth, *args, &block)}
  end

end

