# Generates random subarrays. Uses random numbers and bit-
# fiddling to assure performant uniform distributions even
# for large arrays.
#
#   a = *1..5
#   a.random_subset(2) #=> [[3, 4, 5], []]
#
# CREDIT: Michael Kohl

class Array
  def random_subset(n=1)
    raise ArgumentError, "negative argument" if n < 0
    (1..n).map do
      r = rand(2**self.size)
      self.select.with_index { |_, i| r[i] == 1 }
    end
  end
end
