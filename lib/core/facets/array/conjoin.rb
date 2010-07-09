class Array

  # This is more advanced form of #join. It allows for fine control
  # of separators.
  #
  # NOTE: The old version used to default its separator to ", " and
  # default the terminating separator to " and ". This is no longer
  # the case. You must specifically provide these parameters.
  #
  #   [1,2,3].conjoin
  #   #=> "123"
  #
  # Use comma+space and 'and' on tail.
  #
  #   [1,2,3].conjoin(', ', ' and ')
  #   #=> "1, 2 and 3"
  #
  # Use comma+space and 'or' on tail using :last option.
  #
  #   [1,2,3].conjoin(', ', :last => ' or ')
  #   #=> "1, 2 or 3"
  #
  # Use semicolon+space and ampersand on tail using index.
  #
  #   [1,2,3].conjoin('; ', -1 => ' & ')
  #   #=> "1; 2 & 3"
  #
  # Can take a block to determine separator.
  #
  #   [1,2,3,4].conjoin{ |i, a, b| i % 2 == 0 ? '.' : '-' }
  #   #=> "1.2-3.4"
  #
  # This makes very esoteric transformation possible.
  #
  #   [1,1,2,2].conjoin{ |i, a, b| a == b ? '=' : ' != ' }
  #   #=> "1=1 != 2=2"
  #
  # There are also spacing options. Providing the :space option
  # pads the separators.
  #
  #   [1,2,3].conjoin(',', '&', :space=>2)
  #   #=> "1  ,  2  &  3"
  #
  # And the :spacer option can set an alternate spacing string.
  #
  #   [1,2,3].conjoin('|', '>', :space=>2, :spacer=>'-')
  #   #=> "1--|--2-->--3"
  #
  # CREDIT: Trans

  def conjoin(*args, &block)
    return first.to_s if size < 2

    options = (Hash===args.last) ? args.pop : {}

    spacing = options.delete(:space)  || 0
    spacer  = options.delete(:spacer) || " "
    space   = spacer * spacing.to_i

    sep = []

    if block_given?
      (size - 1).times do |i|
        sep << space + yield(i, *slice(i,2)) + space
      end
    else
      separator   = args.shift || ""
      options[-1] = args.shift if args.first

      options[0]  = options.delete(:first) if options.key?(:first)
      options[-1] = options.delete(:last)  if options.key?(:last)

      separator = space + separator + space

      sep = [separator] * (size - 1)

      options.each{|i, s| sep[i] = space + s + space}
    end
    zip(sep).join
  end

end

