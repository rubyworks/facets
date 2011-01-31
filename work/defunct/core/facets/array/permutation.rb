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

  # Applys a block to each possible permutation of an array.
  #
  #   %w[a b c].each_permutation { |x| puts(x.join('')) }
  #
  # produces
  #
  #   abc
  #   acb
  #   bac
  #   bca
  #   cab
  #   cba
  #
  #  CREDIT: Daniel Sheppard

  def each_permutation()
    pos = Array.new(size) {|i| i}
    s = (0...size).to_a.reverse
    out = nil
    while true
      out = []
      pos.each_with_index {|p,i| out.insert(p, self[i]) }
      yield out
      break if s.each do |i|
        break if pos[i] > 0 && pos[i] -= 1
        pos[i] = i
      end
    end
  end

  # OLD VERSION
  #   #   CREDIT: Florian Gross
  #
  #   def each_permutation()
  #       arr = to_a
  #       size = arr.size
  #       perm_count = (1...size).inject(0) { |s,x| s + x * x.factorial }
  #       weights = Array.new(size-1) {|i| (i+1).factorial }
  #       s = weights.size
  #       x,i,v,pos = nil
  #       0.upto(perm_count) do |v|
  #           out = arr[0..0]
  #           arr.each_with_index {|x,i|
  #               case i
  #                   when 0: next
  #                   when s: out.insert(v / weights[i-1], x)
  #                   else out.insert(v % weights[i] / weights[i-1], x)
  #               end
  #           }
  #           yield out
  #       end
  #   end

end

