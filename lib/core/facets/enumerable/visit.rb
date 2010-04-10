module Enumerable

  # Recursively iterate over all Enumerable elements, or
  # subset given <code>:type=>[type1, type2, ...]</code>.
  #
  #   [1, 2, 8..9].visit{ |x| x.succ }
  #   # => [2, 3, [9, 10]]
  #
  def visit(opts={}, &block)
    type = opts[:type] ? [opts[:type]].flatten : [Enumerable]
    skip = opts[:skip]

    map do |v|
      case v
      when String # b/c of 1.8
        b.call(v)
      when *type
        v.recursive(opts).send(op,&b)
      else
        if skip && Enumerable === v
          v
        else
          b.call(v)
        end
      end
    end
  end

end

