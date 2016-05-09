#--
# Credit goes to  Lucas Carlson and Blaine Cook.
#++

class String

  def starts_with?(str)
    self.index( str ) == 0
  end

  def ends_with?(str)
    self.rindex( str ) == self.length - str.length
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
