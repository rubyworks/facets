require 'facets/string/format'

class String
  def format( *args )
    self.%(args)
  end
end

def String.format(*args)
  Kernel.format(*args)
end

def String.sprintf(*args)
  Kernel.format(*args)
end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO

