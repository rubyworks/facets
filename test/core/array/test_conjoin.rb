covers 'facets/array/conjoin'

testcase Array do

  setup "any array" do
    [1,2,3,4]
  end

  unit :conjoin => "like join but spaced" do |a|
    a.conjoin.assert == "1 2 3 4"
  end

  unit :conjoin => "comma+space and 'and' on tail" do |a|
    a.conjoin(', ', ' and ').assert = "1, 2, 3 and 4"
  end

  unit :conjoin => "comma+space and 'or' on tail using :last option" do |a|
    a.conjoin(', ', :last => ' or ').assert == "1, 2, 3 or 4"
  end

  unit :conjoin => "semicolon+space and ampersand on tail using index" do |a|
    a.conjoin('; ', -1 => ' & ').assert == "1; 2; 3 & 4"
  end

  unit :conjoin => "with block to determine separator" do |a|
    r = a.conjoin{ |i, a, b| i % 2 == 0 ? '.' : '-' }
    r.assert == "1.2-3.4"
  end

  unit :conjoin => "very esoteric transformation" do |a|
     r = a.conjoin{ |i, x, y| "<#{i} #{x} #{y}>" }
     r.assert == "1<0 1 2>2<1 2 3>3<2 3 4>4"
  end

  unit :conjoin => "with :space option" do |a|
    r = a.conjoin(',', '&', :space=>2)
    r.assert == "1  ,  2  ,  3  &  4"
  end

  unit :conjoin => ":spacer option can set an alternate spacing string" do |a|
    r = a.conjoin('|', '>', :space=>2, :spacer=>'-')
    r.assert == "1--|--2--|--3-->--4"
  end

end

