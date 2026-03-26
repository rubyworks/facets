covers 'facets/array/to_proc.rb'

test_case Array do

  method :to_proc do
    test do
      the_hash = { one: "One", two: "Two", three: 3, four: nil }
      the_hash.select(&[[:[], 1], [:is_a?, String]]).
        assert == { :one => "One", :two => "Two" }
      the_hash.values.map(&[:to_s, :downcase, [:sub, /one|two|$^/, { "one" => "1", "two" => "2", "" => "0" }]]).
        assert == ["1", "2", "3", "0"]
    end

  end

end

