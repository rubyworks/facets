class Array

  # This is more advnaced form of #join. It allows for fine control
  # of separators.
  #
  # NOTE: The old version used to default it's separator to ", " and
  # default the terminating separator to " and ". This is no longer
  # the case. You must specifically provide these parameters.
  #
  #   [1,2,3].conjoin
  #   => "123"
  #
  #   [1,2,3].conjoin(', ', ' and ')
  #   => "1, 2 and 3
  #
  #   [1,2,3].conjoin(', ', :last => ' or ')
  #   => "1, 2 or 3
  #
  #   [1,2,3].conjoin('; ', -1 => ' & ')
  #   => "1; 2 & 3
  #
  #   [1,2,3,4].conjoin{ |i, a, b| i % 2 == 0 ? '.' : '-' }
  #   => "1.2-3.4"
  #
  #   [1,1,2,2].conjoin{ |i, a, b| a == b ? '=' : '!=' }
  #   => "1=1!=2=2"
  #
  #  CREDIT: Trans

  def conjoin(*args, &block)
    return first.to_s if size < 2

    sep = []

    if block_given?
      (size - 1).times do |i|
        sep << yield(i, *slice(i,2))
      end
    else
      options   = (Hash===args.last) ? args.pop : {}
      separator = args.shift || ""
      options[-1] = args.shift unless args.empty?

      sep = [separator] * (size - 1)

      if options.key?(:last)
        options[-1] = options.delete(:last)
      end

      options[-1] ||= " and "

      options.each{|i, s| sep[i] = s}
    end
    zip(sep).join
  end

end

