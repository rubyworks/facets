module Kernel

  # Repeat loop until it yeilds false or nil.
  #
  #   a = [3, 2, 1]
  #   complete do
  #     b << a.pop
  #   end
  #   b  #=> [3, 2, 1, nil]
  #
  #  CREDIT: Trans

  def complete
    loop { break unless yield }
  end

end

