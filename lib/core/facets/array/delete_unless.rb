class Array

  # Inverse of #delete_if.
  #
  #   [1,2,3].delete_unless{ |x| x < 2 }
  #   #=> [1]
  #
  # CREDIT: Daniel Schierbeck

  def delete_unless(&block)
    delete_if { |element| not block.call(element) }
  end

end

