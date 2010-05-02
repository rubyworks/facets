require 'facets/enumerable/each_by'

Case Enumerable do

  Unit :each_by => "infer groups of two" do
    e = [[1,2], [3,4], [5,6]]
    a = [1,2,3,4,5,6]
    r = []
    a.each_by{ |a,b| r << [a,b] }
    r.assert == e
  end

  Unit :each_by => "infer groups of three" do
    e = [[1,2,3],[4,5,nil]]
    a = [1,2,3,4,5]
    r = []
    a.each_by{ |a,b,c| r << [a,b,c] }
    r.assert == e
  end

  Unit :each_by => "specify groups of two" do
    e = [[1,2],[3,4]]
    a = [1,2,3,4]
    r = []
    a.each_by(2){ |a,b| r << [a,b] }
    r.assert == e
  end

  Unit :each_by => "specify groups of three with splat argument" do
    e = [ [[1,2,3]], [[4,5,6]] ]
    a = [1,2,3,4,5,6]
    r = []
    a.each_by(3){ |*a| r << a }
    r.assert == e
  end

  Unit :each_by => "specify groups of four with splat argument" do
    e = [ [[1,2,3,4]], [[5,6,7,8]] ]
    a = [1,2,3,4,5,6,7,8]
    r = []
    a.each_by(4){ |*a| r << a }
    r.assert == e
  end

end
