covers 'facets/hash/collate'

test_case Hash do

  setup do
    @a = { :a=>1, :b=>2, :z=>26, :all=>%w|a b z|, :stuff1=>%w|foo bar|, :whee=>%w|a b| }
    @b = { :a=>1, :b=>4, :c=>9,  :all=>%w|a b c|, :stuff2=>%w|jim jam|, :whee=>%w|a b| }
    @c = { :a=>1, :b=>8, :c=>27 }
  end

  method :collate do

    test do
      collated = @a.collate(@b)

      collated.keys.length.assert == 8

      collated[:a].assert == [1,1]
      collated[:b].assert == [2,4]
      collated[:c].assert == [9]
      collated[:z].assert == [26]

      collated[:all].assert == %w|a b z a b c|
      collated[:stuff1].assert == %w|foo bar|
      collated[:stuff2].assert == %w|jim jam|
      collated[:whee].assert == %w|a b a b|
    end

    test "multiple times" do
      collated = @a.collate(@b).collate(@c)

      collated[:a].assert == [1,1,1]
      collated[:b].assert == [2,4,8]
      collated[:c].assert == [9,27]
    end

  end

  method :collate! do

    test "in place variant of #collate" do
      collated = @a.dup
      collated.collate!(@b)

      collated.keys.length.assert == 8

      collated[:a].assert == [1,1]
      collated[:b].assert == [2,4]
      collated[:c].assert == [9]
      collated[:z].assert == [26]

      collated[:all].assert == %w|a b z a b c|
      collated[:stuff1].assert == %w|foo bar|
      collated[:stuff2].assert == %w|jim jam|
      collated[:whee].assert == %w|a b a b|
    end

  end

end

