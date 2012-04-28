class Hash

  # Any array values will be replaced with the first element of the array.
  # Arrays with no elements will be set to nil.
  #
  #   h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
  #   h.dearray_values  #=> { :a=>1, :b=>1, :c=>3, :d=>nil }
  #
  # CREDIT: Trans

  def dearray_values(index=0)
    h = {}
    each do |k,v|
      case v
      when Array
        h[k] = v[index] || v[-1]
      else
        h[k] = v
      end
    end
    h
  end

  # Any array values with one or no elements will be set to the element
  # or nil.
  #
  #   h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
  #   h.dearray_singular_values  #=> { :a=>1, :b=>[1,2], :c=>3, :d=>nil }
  #
  # CREDIT: Trans

  def dearray_singular_values
    h = {}
    each do |k,v|
      case v
      when Array
        h[k] = (v.size < 2) ? v[0] : v
      else
        h[k] = v
      end
    end
    h
  end

end

