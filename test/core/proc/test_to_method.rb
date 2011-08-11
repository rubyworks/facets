covers 'facets/proc/to_method'

test_case Proc do

  method :to_method do

    test do
      o = Object.new
      tproc = proc { |x| x + 2 }

      tmeth = tproc.to_method(o, :tryit)

      tmeth.call(1).assert == 3
      o.assert.respond_to?(:tryit)
      o.tryit(1).assert == 3
    end

    test "with immutable object" do
      o = :foo
      tproc = proc{ self }

      tmeth = tproc.to_method(o, :tryit)

      tmeth.call.assert == :foo
      o.assert.respond_to?(:tryit)
      o.tryit.assert == :foo
    end

    test "ensure method is in object scope" do
      o = Struct.new(:a).new(1)
      tproc = proc{ a }

      tmeth = tproc.to_method(o, :tryit)

      tmeth.call.assert == 1
      o.assert.respond_to?(:tryit)
      o.tryit.assert == 1
    end

  end

end

