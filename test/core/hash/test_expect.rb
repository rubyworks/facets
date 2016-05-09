covers 'facets/hash/except'

test_case Hash do

  method :except do

    test do
      h = {:a=>1, :b=>2, :c=>3}
      h.except(:a).assert == {:b=>2,:c=>3}
    end

  end

  method :except! do

    test do
      h = {:a=>1, :b=>2, :c=>3}
      h.except!(:a).assert == {:b=>2,:c=>3}
      h.assert == {:b=>2,:c=>3}
    end

  end

  method :remove! do

    test do
      h = {:a=>1, :b=>2, :c=>3}
      h.remove!(:a).assert == {:a=>1}
      h.assert == {:b=>2,:c=>3}
    end

  end

end
