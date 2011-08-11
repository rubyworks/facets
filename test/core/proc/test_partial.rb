covers 'facets/proc/partial'

test_case Proc do

  method :partial do

    test "first argument" do
      f = Proc.new{ |a,b,c| a + b + c }
      n = f.partial(NA,2,3)
      n[1].assert == 6
    end

    test "second argument" do
      f = Proc.new{ |a,b,c| a + b + c }
      n = f.partial(1,NA,3)
      n[2].assert == 6
    end

    test "third argument" do
      f = Proc.new{ |a,b,c| a + b + c }
      n = f.partial(1,2,NA)
      n[3].assert == 6
    end

  end

end
