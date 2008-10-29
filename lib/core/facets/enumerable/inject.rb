module Enumerable

  # A small variation of #Inject that save one from having to 
  # return the aggregating or memo argument.
  #
  # Say you want to count letters.
  #
  #    some_text.inject!(Hash.new(0)) {|h,l| h[l] += 1}
  #
  # vs
  #
  #    some_text.inject(Hash.new(0)) {|h,l| h[l] +=1; h}
  #
  #  CREDIT: David Black
  #  CREDIT: Louis J Scoras

  def inject!(s)
    k = s
    each { |i| yield(k, i) }
    k
  end

  # HERE AS BACKUP, TO ENSURE THE ABOVE HAS THE SAME FUNCTIONALITY.
  #def injecting(s)
  #  inject(s) do |k, i|
  #    yield(k, i); k
  #  end
  #end

end

