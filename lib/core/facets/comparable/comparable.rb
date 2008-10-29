# It would nice if we could the following. Then the middle portion of the #Comparable
# method would not be needed. But I fear it might break others code.
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

class Module

  # Automatically generate sorting defintions base on attribute fields.
  #
  #   include SortOn(:a, :b)
  #
  # is equivalent to including a module containing:
  #
  #   def <=>(other)
  #     cmp = self.a <=> other.a; return cmp unless cmp == 0
  #     cmp = self.b <=> other.b; return cmp unless cmp == 0
  #     0
  #   end

  def Comparable(*accessors)
    define_method(:comparability){ accessors }
    code = %{
      def <=>(other)
        comparability.each do |a|
          cmp = (send(a) <=> other.send(a)); return cmp unless cmp == 0
        end
      end
    }
    module_eval code
    return Comparable
  end

end

