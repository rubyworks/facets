module Enumerable

  # In Statistics mode is the value that occurs most frequently
  # in a given set of data. This method returns an array in case
  # their is a tie.
  #
  #   [:a, :b, :c, :b, :d].mode  #=> [:b]
  #   [:a, :b, :c, :b, :a].mode  #=> [:a, :b]
  #
  # Returns an Array of most common elements.
  #
  # CREDIT: Robert Klemme

  def mode
    max = 0
    c = Hash.new 0
    each {|x| cc = c[x] += 1; max = cc if cc > max}
    c.select {|k,v| v == max}.map {|k,v| k}
  end

end

