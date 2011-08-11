covers 'facets/hash/data'

test_case Hash do

  method :data do

    test do
      h = {:a=>1, :b=>2}

      h.data.a.assert == 1
      h.data.b.assert == 2
      h.data.c.assert == nil
    end

    test do
      h = {:a=>1, :b=>2}

      h.data.c = 3
      h.data.c.assert == 3
    end

    test do
      h = {:a=>1, :b=>2}

      # Note, we can't apply a functor to a functor.
      #h.data.assert.a?
      #h.data.refute.d?

      h.data.a?.assert == true
      h.data.d?.assert == false
    end

  end

end
