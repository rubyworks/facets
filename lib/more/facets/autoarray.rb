# AutoArray
# Copyright (c) 2005 Brian Schröder

# An Array that automatically expands dimensions as needed.
#
#   a  = Autoarray.new
#   a[1][2][3] = 12
#   a             #=> [nil, [nil, nil, [nil, nil, nil, 12]]]
#   a[2][3][4]    #=> []
#   a             #=> [nil, [nil, nil, [nil, nil, nil, 12]]]
#   a[1][-2][1] = "Negative"
#   a             #=> [nil, [nil, [nil, "Negative"], [nil, nil, nil, 12]]]
#
class AutoArray < Array

  def initialize(size=0, default=nil, update = nil, update_index = nil)
    super(size, default)
    @update, @update_index = update, update_index
  end

  def [](k)
    if -self.length+1 < k and k < self.length
      super(k)
    else
      Autoarray.new(0, nil, self, k)
    end
  end

  def []=(k, v)
    @update[@update_index] = self if @update and @update_index
    super
  end

end
