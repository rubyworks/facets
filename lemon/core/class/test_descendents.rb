require 'facets/class/descendents.rb'

class A ; end
class B < A ; end
class C < B ; end

TestCase Class do

  Unit :descendents do
    A.descendents.assert == [C,B]
  end

end

