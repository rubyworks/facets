class Array

  # Index operator.
  #
  #  a = [:a, :b, :c]
  #  (a/1)  #=> :a
  alias_method :/, :[]

  # DEPRECATED -- Use 'each_slice(n).to_a' as of 1.9.
  # Partition an array into parts of given length.
  #
  # CREDIT: WhyTheLuckyStiff ...
  #
  #   def / len
  #     inject([]) do |ary, x|
  #       ary << [] if [*ary.last].nitems % len == 0
  #       ary.last << x
  #       ary
  #     end
  #   end

end

