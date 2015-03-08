covers 'facets/array/each_value'

test_case Array do

  method :each_value do

    test do
      a = [ "a", "b", "c" ]
      out = ''
      a.each_value {|x| out +=  "#{x} -- " }
      out.assert == 'a -- b -- c -- '
    end

  end

end
