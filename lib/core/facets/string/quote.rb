class String

  # Return a new string embraced by given +type+ and +count+
  # of quotes. If no type or count is given, double quotes
  # are assumed. If no type bu count is given then 'single' 
  # is assumed.
  #
  #   "quote me".quote     #=> "'quote me'"
  #   "quote me".quote(2)  #=> "\"quote me\""
  #   "quote me".quote(3)  #=> "'\"quote me\"'"
  #
  # CREDIT: Trans

  def quote(type=:double, count=nil)
    if Integer==type
      count = type
      type  = count || :single
    else
      count ||= 1
    end

    case type.to_s.downcase
    when "'", 'single', 's'
      f = "'" * count
      b = f
    when '"', 'double', 'd'
      f = '"' * count
      b = f
    when '`', 'back', 'b'
      f = '`' * count
      b = f
    when "`'", 'singlebracket', 'sb'
      f = "`" * count
      b = "'" * count
    when "'\"", 'mixed', "m"
      f = '"' * (count / 2)
      b = f
      if count % 2 != 0
        f = "'" + f
        b = b + "'"
      end
    else
      raise ArgumentError, "unrecognized quote type -- #{type}"
    end
    "#{f}#{self}#{b}"
  end

end

