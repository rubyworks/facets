require 'facets/proc/bind_to'

TestCase Proc do

  Unit :bind_to => '' do
     a = [1,2,3]
     p1 = Proc.new{ join(' ') }
     p2 = p1.bind_to(a)
     p2.call.assert == '1 2 3'
  end

end

