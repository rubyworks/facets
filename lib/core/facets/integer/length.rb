#
# Calculate the number of digits in an integer.
#
# 1.length   #=> 1
# 10.length  #=> 2
# 100.length #=> 3
#
# CREDIT: Victor H. Goff III

class Integer
  # Returns the length of an integer as an integer.
  def length
    to_s.length
  end
end

