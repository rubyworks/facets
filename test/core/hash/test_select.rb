Covers 'facets/hash/select'

Case Hash do

  Unit :select! => "empty hash" do
    a = {}
    a.select!{false}.assert == nil
    a.assert == {}

    a = {}
    a.select!{true}.assert == nil
    a.assert == {}
  end

  Unit :select! => "select none" do
    a = {0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd'}
    a.select!{false}.assert == {}
    a.assert == {}
  end

  Unit :select! => "select one" do
    a = {0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd'}
    a.select! {|x,y| y == 'b'}.assert == {1 => 'b'}
    a.assert == {1 => 'b'}
  end

  Unit :select! => "select some" do
    a = {0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd'}
    a.select! {|x,y| x % 2 == 0}.assert == {0 => 'a', 2 => 'c'}
    a.assert == {0 => 'a', 2 => 'c'}
  end

  Unit :select! => "select all" do
    a = {0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd'}
    a.select!{true}.assert == nil
    a.assert == {0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd'}
  end

end

