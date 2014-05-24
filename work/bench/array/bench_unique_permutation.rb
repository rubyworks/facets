class Array

  def unique_permutation(n=self.size)
    return to_enum(:unique_permutation,n) unless block_given?
    return if n<0||self.size<n
    a=self.sort
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

FIXTURE=[0,0,0,1,1,1,2,2,2].sort
raise if FIXTURE.permutation.to_a.uniq!=FIXTURE.unique_permutation.to_a

a=FIXTURE.permutation.to_a.uniq
#p a

a=FIXTURE.unique_permutation.to_a
#p a
