Covers 'facets/kernel/deep_copy'

Case Kernel do

  module DeepCopyHelpers
    class A
      attr_reader :a
      def initialize
        @a = 1
      end
    end

    class B
      attr_reader :b
      def initialize
        @b = A.new
      end
    end
  end

  Unit :deep_copy do
    o = DeepCopyHelpers::B.new
    oc = o.deep_copy
    o.b.a.assert == 1
  end

end
