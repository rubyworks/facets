covers 'facets/hash/deep_merge'

test_case Hash do

  method :deep_merge do

    test do
      h1 = { :a=>1, :c=>{:x=>10} }
      h2 = { :b=>2, :c=>{:y=>11} }

      h = h1.deep_merge(h2)

      h.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
    end

  end

  method :deep_merge! do

    test do
      h1 = { :a=>1, :c=>{:x=>10} }
      h2 = { :b=>2, :c=>{:y=>11} }

      h1.deep_merge!(h2)

      h1.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
    end

  end

end
