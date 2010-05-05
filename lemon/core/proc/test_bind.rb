Covers 'facets/proc/bind'

Case Proc do

  # Not sure why this is thread critical?
  Unit :bind => "thread critial" do
    a = 2
    tproc = lambda { |x| x + a }
    99.times {
      tmethod = tproc.bind(self) #to_method
      tmethod.call(1).assert == 3
    }

    meths = (
      Object.instance_methods +
      Object.public_instance_methods +
      Object.private_instance_methods +
      Object.protected_instance_methods
    )
    meths = meths.select{ |s| s.to_s =~ /^_bind_/ }
    #meths = Symbol.all_symbols.select { |s| s.to_s =~ /^_bind_/ }  # why?

    meths.size.assert == 0
  end

end
