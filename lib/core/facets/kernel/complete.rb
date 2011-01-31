module Kernel

  # Repeat loop until it yeilds false or nil.
  #
  #   a = [3, 2, 1]
  #   b = []
  #
  #   complete do
  #     x = a.pop
  #     b << x
  #     x
  #   end
  #
  #   b  #=> [1, 2, 3, nil]
  #
  # Be "aware" when using this method, it easy to accidently
  # induce infinite loops.
  #
  # CREDIT: Trans

  def complete
    loop { break unless yield }
  end

end

