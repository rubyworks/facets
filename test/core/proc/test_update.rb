covers 'facets/proc/update'

testcase Proc do

  unit :update => '' do
    p1 = Proc.new{ 'here' }
    p1.update.assert == 'here'
  end

end

