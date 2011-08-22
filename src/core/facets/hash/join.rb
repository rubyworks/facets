class Hash

  # Like Array#join but specialized to Hash.
  #
  # NOTE: Without Ruby 1.9 this would be difficult to rely on becuase
  # hashes did not have a strict order.
  #
  # CREDIT: Mauricio Fernandez

  def join(pair_divider='', elem_divider=nil)
    elem_divider ||= pair_divider
    s = []
    each{ |k,v| s << "#{k}#{pair_divider}#{v}" }
    s.join(elem_divider)
  end

end
