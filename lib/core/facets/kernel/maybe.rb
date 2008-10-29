module Kernel

  # Random generator that returns true or false.
  # Can also take a block that has a 50/50 chance to being executed.
  #
  #   maybe  #=> true
  #   maybe  #=> false
  #
  def maybe(chance = 0.5, &block)
    if block then
      yield if rand < chance
    else
      rand < chance
    end
  end

end

