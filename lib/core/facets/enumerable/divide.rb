module Enumerable

  # Divide on matching pattern.
  #
  #   ['a1','b1','a2','b2'].divide(/^a/)
  #   => [['a1,'b1'],['a2','b2']]
  #
  #  CREDIT: Trans

  def divide(pattern)
    memo = []
    each do |obj|
      memo.push [] if pattern === obj
      memo.last << obj
    end
    memo
  end

  # DEPRECATED -- Use 'each_slice(n).to_a' as of 1.9.
  # Partition an array into parts of given length.
  #
  # CREDIT WhyTheLuckyStiff
  #
  #   def / len
  #     inject([]) do |ary, x|
  #       ary << [] if [*ary.last].nitems % len == 0
  #       ary.last << x
  #       ary
  #     end
  #   end

end

