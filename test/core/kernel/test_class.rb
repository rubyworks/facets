covers 'facets/kernel/__class__'

test_case Kernel do

  method :__class__ do

    test do
      o = Object.new
      o.__class__.assert == o.class
    end

  end

end
