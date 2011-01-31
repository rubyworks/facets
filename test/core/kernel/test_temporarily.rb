covers 'facets/kernel/temporarily'

tests Kernel do

  unit :temporarily => "global variable" do
    $temporary_variable = true
    temporarily('$temporary_variable'=>false) do
      $temporary_variable.assert == false
    end
    $temporary_variable.assert == true
  end

  unit :temporarily => "instance variable" do
    @x = 1
    temporarily('@x'=>2) do
      @x.assert == 2
    end
    @x.assert == 1
  end

end
