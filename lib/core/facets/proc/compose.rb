class Proc

  # @deprecated Use Proc#>> or Proc#<< instead (built-in since Ruby 2.6).
  #   Scheduled for removal after 2027-09-30.
  def compose(g)
    warn "Proc#compose is deprecated. Use Proc#<< instead (right-to-left composition). It will be removed after 2027-09-30.", uplevel: 1
    self << g
  end

  # @deprecated Use Proc#>> or Proc#<< for composition (built-in since Ruby 2.6).
  #   Scheduled for removal after 2027-09-30.
  def *(x)
    warn "Proc#* is deprecated. Use Proc#<< for composition (right-to-left). It will be removed after 2027-09-30.", uplevel: 1
    if Integer === x
      c = []
      x.times{|i| c << call(i)}
      c
    else
      self << x
    end
  end

end
