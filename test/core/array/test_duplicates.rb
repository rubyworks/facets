covers 'facets/array/duplicates'

test_case Array do

  method :duplicates do

    test do
      a = [1,1,2,2,3,4,5]
      a.duplicates.sort.assert == [1,2]
    end

    test "with minimum" do
      a = [0,1,2,3,4,5,
           0,1,2,3,4,
           0,1,2,3,
           0,1,2,
           0,1,
           0]
      (1..6).each do |m|
        d = a.duplicates(m).sort
        e = [*0..6-m]
        d.assert == e
      end
    end

  end

end

