covers 'facets/proc/bind_to'

test_case Proc do

  method :bind_to do

    test do
       a = [1,2,3]
       p1 = Proc.new{ join(' ') }
       p2 = p1.bind_to(a)
       p2.call.assert == '1 2 3'
    end

  end

end

