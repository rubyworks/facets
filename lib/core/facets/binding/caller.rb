require 'facets/binding/callstack'

class Binding

  # Returns the call stack, same format as Kernel#caller()
  #
  def caller( skip=0 )
    eval("caller(#{skip})")
  end

  # Returns the call stack, same format as Kernel#caller_locations()
  #
  def caller_locations( skip=0 )
    eval("caller_locations(#{skip})")
  end

  # Return the line number on which the binding was created.
  #
  def __LINE__
    self.source_location[1]
  end

  # Returns file name in which the binding was created.
  #
  def __FILE__
    self.source_location[0]
  end

  # Return the directory of the file in which the binding was created.
  #
  def __DIR__  
    File.dirname(self.__FILE__)
  end

  # Retreive the current running method.
  #
  def __method__
    Kernel.eval("__method__", self)
  end

  # Retreive the current running method.
  #
  def __callee__
    Kernel.eval("__callee__", self)
  end

end

