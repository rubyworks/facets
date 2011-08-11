covers 'facets/hash/reverse_merge'

test_case Hash do

  method :reverse_merge do

    test do
      h1 = { :a=>1, :b=>2, :c=>2 }
      h2 = { :c=>3 }
      h3 = h1.reverse_merge(h2)
      h3[:c].assert == 2
    end

  end

  method :reverse_merge! do

    test do
      h1 = { :a=>1, :b=>2, :c=>2 }
      h2 = { :c=>3 }
      h1.reverse_merge!(h2)
      h1[:c].assert == 2
    end

  end

  method :reverse_update do

    test do
      h1 = { :a=>1, :b=>2, :c=>2 }
      h2 = { :c=>3 }
      h1.reverse_update(h2)
      h1[:c].assert == 2
    end

  end

end

