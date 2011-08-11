covers 'facets/string/xor'

test_case String do

  method :'^' do

    test do
      r = "try this out" ^ "puddingsnacks"
      x = "\004\a\035D\035\006\016\000N\016\026\037"
      r.assert == x
    end

  end

end

