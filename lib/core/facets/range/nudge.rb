class Range

  # Nudge range values
  #
  #   (1..5).nudge           #=> 2..6
  #   (1..5).nudge(2)        #=> 3..7
  #   (1..5).nudge(-2)       #=> -1..3
  #   (1..5).nudge(min: 1)   #=> 2..5
  #   (1..5).nudge(max: 1)   #=> 1..6
  #
  # CREDIT: Codeindulgence

  def nudge(options_or_number = 1)
    if options_or_number.instance_of? Fixnum
      {:min => options_or_number, :max => options_or_number}
      min = options_or_number
      max = options_or_number
    else
      min = options_or_number[:min].to_i
      max = options_or_number[:max].to_i
    end

    if exclude_end?
      (self.min + min)...((self.max + 1) + max)
    else
      (self.min + min)..(self.max + max)
    end
  end
end
