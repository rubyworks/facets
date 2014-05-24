class Array

  # Enumerates permutation of Array.
  # Unlike Array#permutation, there are no duplicates in generated permutations.
  # Instead, elements must be comparable.
  #
  #   [1,1,2,2,3].unique_permutation(2).to_a
  #   #=> [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2]]
  #   # Note: [1,1,2,2,3].permutation(2).to_a
  #   #=> [[1, 1], [1, 2], [1, 2], [1, 3], [1, 1], [1, 2], [1, 2], [1, 3], [2, 1], [2, 1], [2, 2], [2, 3], [2, 1], [2, 1], [2, 2], [2, 3], [3, 1], [3, 1], [3, 2], [3, 2]]
  #
  # CREDIT: T. Yamada
  def unique_permutation(n=self.size)
    return to_enum(:unique_permutation,n) unless block_given?
    return if n<0||self.size<n
    a=self.sort # sort is O(nlogn), so I believe this is not so costly. (Also sort is not destructive)
    yield a[0,n]
    loop{
      a=a[0,n]+a[n..-1].reverse
      k=(a.size-2).downto(0).find{|i|a[i]<a[i+1]}
      break if !k
      l=(a.size-1).downto(k+1).find{|i|a[k]<a[i]}
      a[k],a[l]=a[l],a[k]
      a=a[0,k+1]+a[k+1..-1].reverse
      yield a[0,n]
    }
  end
 
end
