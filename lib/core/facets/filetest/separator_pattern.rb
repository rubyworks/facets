module FileTest

  #
  SEPARATOR_PATTERN = (
    if File::ALT_SEPARATOR
      /[#{Regexp.quote File::ALT_SEPARATOR}#{Regexp.quote File::SEPARATOR}]/
    else
      /#{Regexp.quote File::SEPARATOR}/
    end
  ).freeze

  #module_function
  #
  #  #
  #  def separator_pattern
  #    SEPARATOR_PATTERN
  #  end

end
