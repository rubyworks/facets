require 'facets/array/index'

TestCase Array do

  Unit :index => "can handle a block" do
    i = [1,2,3].index{ |e| e == 2 }
    i.assert == 1
  end

  Unit :index => "when no element is found" do
    i = [1,2,3].index{ |e| e == 5 }
    i.assert.nil?
  end

end

