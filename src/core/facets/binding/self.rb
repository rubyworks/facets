require 'facets/binding/eval'

class Binding

  # Returns self of the binding context.

  def self()
    @_self ||= eval("self")
  end

end

