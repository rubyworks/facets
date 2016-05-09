class String

  def dequote
    s = self.dup

    case self[0,1]
    when "'", '"', '`'
      s[0] = ''
    end

    case self[-1,1]
    when "'", '"', '`'
      s[-1] = ''
    end

    s
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO

