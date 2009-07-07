require 'facets/kernel/method'

module Kernel

  private

  # Returns the method object of the current method.
  def this
    line = nil
    caller(1).each do |line|
      line = /\`([^\']+)\'/.match(line)
      break if line
    end
    if line
      name = line[1]
      return method(name)
    else
      raise NoMethodError
    end
  end

  #
  def this!
    line = nil
    caller(1).each do |line|
      line = /\`([^\']+)\'/.match(line)
      break if line
    end
    if line
      name = line[1]
      return method!(name)
    else
      raise NoMethodError
    end   
  end

end

