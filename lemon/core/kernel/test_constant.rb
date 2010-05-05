Covers 'facets/kernel/constant'

Case Kernel do

  module ConstantHelpers
    module A
      module B
        module C
        end
      end
    end
  end

  Unit :constant do
    c = ConstantHelpers::A::B::C.name
    constant(c).assert == ConstantHelpers::A::B::C

    c = "A::B::C"
    ConstantHelpers.constant(c).assert == ConstantHelpers::A::B::C

    c = "B::C"
    ConstantHelpers::A.constant(c).assert == ConstantHelpers::A::B::C

    c = "C"
    ConstantHelpers::A::B.constant(c).assert == ConstantHelpers::A::B::C
  end

end

