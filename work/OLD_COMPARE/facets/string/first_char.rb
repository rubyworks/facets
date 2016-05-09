require 'facets/string/last_char'

class String
  # Returns first _n_ characters.
  #
  #   "Hello World".first_char(3)  #=> "Hel"
  #
  def first_char(n=1)
    slice(0, n.to_i)
  end
end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
