covers 'facets/array/only.rb'

testcase Array do

  unit :only do
    [5].only.assert == 5
    [nil].only.assert == nil
    expect(IndexError){ [].only }
    expect(IndexError){ [1,2,3].only }
  end

end

