class String

  # OLD VERSION OF CAMELCASE

  # Converts a string to camelcase. By default capitalization
  # occurs on whitespace and underscores. By setting the first
  # parameter to <tt>true</tt> the first character can also be
  # captizlized. The second parameter can be assigned a valid
  # Regualr Expression characeter set to determine which
  # characters to match for capitalizing subsequent parts of
  # the string.
  #
  #   "this_is a test".camelcase             #=> "thisIsATest"
  #   "this_is a test".camelcase(true)       #=> "ThisIsATest"
  #   "this_is a test".camelcase(true, ' ')  #=> "This_isATest"
  #
  def camelcase( first=false, on='_\s' )
    if first
      gsub(/(^|[#{on}]+)([A-Za-z])/){ $2.upcase }
    else
      gsub(/([#{on}]+)([A-Za-z])/){ $2.upcase }
    end
  end

end
