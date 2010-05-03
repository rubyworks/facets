require 'facets/proc/to_method'

Case Proc do

  Unit :to_method do
    o = Object.new
    tproc = proc { |x| x + 2 }

    tmeth = tproc.to_method(o, :tryit)

    tmeth.call(1).assert == 3
    o.assert.respond_to?(:tryit)
    o.tryit(1).assert == 3
  end

  Unit :to_method => "with immutable object" do
    o = :foo
    tproc = proc{ self }

    tmeth = tproc.to_method(o, :tryit)

    tmeth.call.assert == :foo
    o.assert.respond_to?(:tryit)
    o.tryit.assert == :foo
  end

  Unit :to_method => "ensure method is in object scope" do
    o = Struct.new(:a).new(1)
    tproc = proc{ a }

    tmeth = tproc.to_method(o, :tryit)

    tmeth.call.assert == 1
    o.assert.respond_to?(:tryit)
    o.tryit.assert == 1
  end

end

