covers 'facets/proc/update'

test_case Proc do

  method :update do

    test do
      p1 = Proc.new{ 'here' }
      p1.update.assert == 'here'
    end

  end

end

