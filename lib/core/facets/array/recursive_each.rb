class Array

  # Recursively iterate over the Array's elements.
  # If an element is an Array or responds to #to_ary
  # then it will be itereated over as well.
  #
  def recursive_each(&block)
    if block_given?
      each do |e|
        if Array === e || e.respond_to?(:to_ary)
          e.to_ary.recursive_each(&block)
        else
          block.call(e)
        end
      end
    else
      to_enum(:recursive_each)
    end
  end

end

