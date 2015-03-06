class Array

  # Divide on matching pattern.
  #
  #   ['a1','b1','a2','b2'].divide(/^a/)
  #   #=> [['a1','b1'],['a2','b2']]
  #
  # CREDIT: Trans

  def divide(pattern)
    memo = []
    memo.push [] unless pattern === first
    each do |obj|
      memo.push [] if pattern === obj
      memo.last << obj
    end
    memo
  end

end

