#--
# Credit goes to George Moschovitis.
#++
class String

  # Returns short abstract of long strings (first 'count'
  # characters, chopped at the nearest word, appended by '...')
  # force_cutoff: break forcibly at 'count' chars. Does not accept
  # count < 2.
  def brief(string, count = 128, force_cutoff = false, ellipsis="...")
    return nil unless string
    return nil if count < 2

    if string.size > count
      cut_at = force_cutoff ? count : (string.index(' ', count-1) || count)
      xstring = string.slice(0, cut_at)
      return xstring.chomp(" ") + ellipsis
    else
      return string
    end
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO

