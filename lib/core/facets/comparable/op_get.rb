module Comparable

  # Automatically generate comparitive definitions based on
  # attribute fields.
  #
  #   include Comparable[:a, :b]
  #
  # is equivalent to including a module containing:
  #
  #   def <=>(other)
  #     cmp = self.a <=> other.a; return cmp unless cmp == 0
  #     cmp = self.b <=> other.b; return cmp unless cmp == 0
  #     0
  #   end
  #
  def self.[](*accessors)
    Module.new do
      include Comparable
      define_method(:comparability){ accessors }
      define_method(:<=>) do |other|
        comparability.each do |a|
          cmp = (send(a) <=> other.send(a))
          break cmp unless cmp == 0
        end
      end
    end
  end

end

# Would it be nice if we could define comparability for all objects?
# Then Comparable[] method would not be needed. Just:
#
#   module Comparable
#
#    def <=>(other)
#      comparability.each do |field|
#        cmp = send(field) <=> other.send(field); return cmp unless cmp == 0
#      end
#    end
#
#  end
#
# But I fear it might break other code.

