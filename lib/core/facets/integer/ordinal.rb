class Integer

  # The number with its English ordinal suffix.
  #
  #   1.ordinal    #=> "1st"
  #   12.ordinal   #=> "12th"
  #   103.ordinal  #=> "103rd"
  #   -1.ordinal   #=> "-1st"
  #
  def ordinal
    n = abs % 100
    suffix =
      if (11..13).include?(n)
        'th'
      else
        case n % 10
        when 1 then 'st'
        when 2 then 'nd'
        when 3 then 'rd'
        else 'th'
        end
      end
    "#{self}#{suffix}"
  end

  # Rails term.
  alias_method :ordinalize, :ordinal

end
