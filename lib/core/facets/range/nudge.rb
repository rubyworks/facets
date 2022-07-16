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

  def nudge(value = 1, min: nil, max: nil)
    if min or max
      min ||= 0
      max ||= 0
    else
      min = max = value
    end
    
    if exclude_end?
      (self.min + min)...((self.max + 1) + max)
    else
      (self.min + min)..(self.max + max)
    end
  end
end

pp "LOADING NUDGE"
