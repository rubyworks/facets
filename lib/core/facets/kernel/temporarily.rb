module Kernel

  # Temporarily set variables while yielding a block, then return the
  # variables to their original settings when complete.
  #
  #   temporarily('$VERBOSE'=>false) do
  #     $VERBOSE.assert == false
  #   end
  #
  def temporarily(settings) #:yield:
    cache = {}
    settings.each do |var, val|
      cache[var] = eval("var")
      eval("proc{ |v| #{var} = v }").call(val)
    end
    yield
  ensure
    cache.each do |var, val|
      eval("proc{ |v| #{var} = v }").call(val)
    end
  end

end
