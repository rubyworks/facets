require 'facets/string/first_char'

class String
  # Returns last _n_ characters.
  #
  #   "Hello World".last_char(3)  #=> "rld"
  #
  def last_char(n=1)
    n = n.to_i
    return self if n > size
    slice(-n, n) #self[-n..-1]
  end
end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
