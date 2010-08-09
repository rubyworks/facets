Covers 'facets/array/only.rb'

TestCase Array do

  Unit :only do
    [5].only.assert == 5
    [nil].only.assert == nil
    expect(IndexError){ [].only }
    expect(IndexError){ [1,2,3].only }
  end

end

