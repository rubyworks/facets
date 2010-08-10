Covers 'facets/proc/update'

TestCase Proc do

  Unit :update => '' do
    p1 = Proc.new{ 'here' }
    p1.update.assert == 'here'
  end

end

