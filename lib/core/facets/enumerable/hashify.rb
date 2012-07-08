module Enumerable
  #
  def hashify(val=true)
    warn "Enumerable#hashify will be deprecated as of 2013-01-01. Use #value_by instead."
    h = {}
    if block_given?
      each { |item| h[item] = yield(item) }
    else
      each { |item| h[item] = val }
    end
    h
  end
end
