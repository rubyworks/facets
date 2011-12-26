class Array

  # Calculate permutation number.
  #
  #  CREDIT: Florian Gross

  def permutation_number(original_array=self.to_a.sort)
    arr = to_a
    m = 1
    v = 0
    last_indicies = Hash.new(0)
    original_array.each_with_index do |x,i|
      next if i==0
      m *= i
      done = original_array[0..i]
      v += m * arr.select {|y| done.include?(y)}.rindex(x)
    end
    v
  end

end
