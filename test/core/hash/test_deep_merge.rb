covers 'facets/hash/deep_merge'

test_case Hash do

  method :deep_merge do

    test do
      h1 = { :a=>1, :c=>{:x=>10} }
      h2 = { :b=>2, :c=>{:y=>11} }

      h = h1.deep_merge(h2)

      h.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
    end

    test "a block decides values both hashes have" do
      h = {a: {b: 1}, c: 1}.deep_merge(a: {b: 2}, c: 2) { |key, mine, theirs| mine + theirs }
      h.assert == {a: {b: 3}, c: 3}
    end

    test "a value that isn't a hash replaces a sub-hash" do
      {a: {b: 1}}.deep_merge(a: 2).assert == {a: 2}
      {a: 1}.deep_merge(a: {b: 2}).assert == {a: {b: 2}}
    end

    test "merges sub-hashes of Hash subclasses too" do
      special = Class.new(Hash)
      {a: special[b: 1]}.deep_merge(a: {c: 2}).assert == {a: {b: 1, c: 2}}
      {a: {b: 1}}.deep_merge(a: special[c: 2]).assert == {a: {b: 1, c: 2}}
    end

    test "honors #deep_merge?, which ActiveSupport defines" do
      picky = Class.new(Hash) { def deep_merge?(other) = false }
      {a: picky[b: 1]}.deep_merge(a: {c: 2}).assert == {a: {c: 2}}
    end

    test "doesn't change the receiver" do
      h1 = {a: {b: 1}}
      h1.deep_merge(a: {c: 2})
      h1.assert == {a: {b: 1}}
    end

  end

  method :deep_merge! do

    test do
      h1 = { :a=>1, :c=>{:x=>10} }
      h2 = { :b=>2, :c=>{:y=>11} }

      h1.deep_merge!(h2)

      h1.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
    end

    test "replaces sub-hashes with merged copies instead of changing them" do
      inner = {b: 1}
      h1 = {a: inner}
      h1.deep_merge!(a: {c: 2})
      h1.assert == {a: {b: 1, c: 2}}
      inner.assert == {b: 1}
    end

    test "takes a block" do
      h1 = {a: {b: 1}}
      h1.deep_merge!(a: {b: 2}) { |key, mine, theirs| [mine, theirs] }
      h1.assert == {a: {b: [1, 2]}}
    end

  end

end
