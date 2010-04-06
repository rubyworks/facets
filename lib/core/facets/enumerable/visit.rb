module Enumerable

  # Recursively iterate over the Enumerable's elements.
  # If an element is also Enumerable, then it will also
  # be visited, and so on.

  def visit(&block)
    if block_given?
      each do |e|
        if Enumerable === e
          e.visit(&block)
        else
          block.call(*e)
        end
      end
    else
      to_enum(:visit, type)
    end
  end

end

