covers 'facets/kernel/temporarily'

test_case Kernel do

  method :temporarily do

    test "global variable" do
      $temporary_variable = true
      temporarily('$temporary_variable'=>false) do
        $temporary_variable.assert == false
      end
      $temporary_variable.assert == true
    end

    test "instance variable" do
      @x = 1
      temporarily('@x'=>2) do
        @x.assert == 2
      end
      @x.assert == 1
    end

  end

end
