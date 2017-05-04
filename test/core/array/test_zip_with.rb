covers 'facets/array/zip_with'

testcase Array do

  setup "test array" do
    [[1,2,3], [6,5,4]]
  end

  unit :zip_with => "can zip arrays with a symbol" do |a, b|
    a.zip_with(b, :+).assert == [7,7,7]
  end

  unit :zip_with => "can zip arrays with a block" do |a, b|
    a.zip_with(b) { |a, b| 3 * a + b}.assert == [9, 11, 13]
  end

  unit :zip_with => "will adjust to shorter array" do |a, b|
    a = [1,2,3]
    b = [6,5]
    a.zip_with(b, :+).assert == [7,7]
  end

  unit :zip_with => "will return emoty array if one array is empty" do |a, b|
    a.zip_with([], :+).assert == []
  end

end

