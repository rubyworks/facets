class String

  # Return a new string embraced by given +type+ and +count+
  # of quotes. The arguments can be given in any order.
  #
  # If no type is given, double quotes are assumed.
  #
  #   "quote me".quote     #=> '"quote me"'
  #
  # If no type but a count is given then :mixed is assumed.
  #
  #   "quote me".quote(1)  #=> %q{'quote me'}
  #   "quote me".quote(2)  #=> %q{"quote me"}
  #   "quote me".quote(3)  #=> %q{'"quote me"'}
  #
  # Symbols can be used to describe the type.
  #
  #   "quote me".quote(:single)         #=> %q{'quote me'}
  #   "quote me".quote(:double)         #=> %q{"quote me"}
  #   "quote me".quote(:back)           #=> %q{`quote me`}
  #   "quote me".quote(:single_bracket) #=> %q{`quote me'}
  #
  # Or the character itself.
  #
  #   "quote me".quote("'")     #=> %q{'quote me'}
  #   "quote me".quote('"')     #=> %q{"quote me"}
  #   "quote me".quote("`")     #=> %q{`quote me`}
  #   "quote me".quote("`'")    #=> %q{`quote me'}
  #
  # CREDIT: Trans

  def quote(type=:double, count=nil)
    if Integer === type
      tmp   = count
      count = type
      type  = tmp || :mixed
    else
      count ||= 1
    end

    type = type.to_s unless Integer===type

    case type
    when "'", 'single', 's', 1
      f = "'" * count
      b = f
    when '"', 'double', 'd', 2
      f = '"' * count
      b = f
    when '`', 'back', 'b', -1
      f = '`' * count
      b = f
    when "`'", 'single_bracket', 'sb'
      f = "`" * count
      b = "'" * count
    when "'\"", 'mixed', "m", Integer
      c = (count.to_f / 2).to_i
      f = '"' * c
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

