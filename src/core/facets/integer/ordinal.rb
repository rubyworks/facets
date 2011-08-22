class Integer

  def ordinal
    if [11,12,13].include?(self % 100)
      "#{self}th"
    else
      case (self % 10)
      when 1
        "#{self}st"
      when 2
        "#{self}nd"
      when 3
        "#{self}rd"
      else
        "#{self}th"
      end
    end
  end

  # Rails term.
  alias_method :ordinalize, :ordinal

end

