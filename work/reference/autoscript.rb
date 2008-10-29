require 'script'

class Module
  alias const_missing_before_autoscript const_missing
  
  def const_missing(sym) # :nodoc:
    filename = @autoscript && @autoscript[sym]
    if filename
      mod = Script.load(filename)
      const_set sym, mod
    else
      const_missing_before_autoscript(sym)
    end
  end

  # When the constant named by symbol +mod+ is referenced, loads the script
  # in filename using Script.load and defines the constant to be equal to the
  # resulting Script module.
  #
  # Use like Module#autoload--however, the underlying opertation is #load rather
  # than #require, because scripts, unlike libraries, can be loaded more than
  # once. See examples/autoscript-example.rb
  
  def autoscript mod, filename
    (@autoscript ||= {})[mod] = filename
  end
end

module Kernel
  # Calls Object.autoscript.
  def autoscript mod, filename
    Object.autoscript mod, filename
  end
end
