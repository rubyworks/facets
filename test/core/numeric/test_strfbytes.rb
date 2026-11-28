covers 'facets/numeric/strfbytes'

test_case Numeric do

  method :strfbytes do

    test "under 1024 it is a count of bytes" do
      0.strfbytes.assert == "0 bytes"
      1.strfbytes.assert == "1 byte"
      512.strfbytes.assert == "512 bytes"
      1023.strfbytes.assert == "1023 bytes"
    end

    test "each unit is 1024 of the one before" do
      1024.strfbytes.assert == "1.00 KB"
      (1024**2).strfbytes.assert == "1.00 MB"
      (1024**3).strfbytes.assert == "1.00 GB"
      (1024**4).strfbytes.assert == "1.00 TB"
      (1024**5).strfbytes.assert == "1.00 PB"
      (1024**6).strfbytes.assert == "1.00 EB"
      (1024**7).strfbytes.assert == "1.00 ZB"
      (1024**8).strfbytes.assert == "1.00 YB"
    end

    test "the largest unit is used for anything larger" do
      (1024**9).strfbytes.assert == "1024.00 YB"
    end

    test "a number between units is a fraction" do
      1536.strfbytes.assert == "1.50 KB"
      3000000.strfbytes.assert == "2.86 MB"
    end

    test "takes a format string" do
      1536.strfbytes('%.0f').assert == "2 KB"
      1536.strfbytes('%.1f').assert == "1.5 KB"
      1536.strfbytes('%d').assert == "1 KB"
    end

    test "a number that rounds up to 1024 goes to the next unit" do
      (1024**2 - 1).strfbytes.assert == "1.00 MB"
      (1024**2 - 1).strfbytes('%.0f').assert == "1 MB"
    end

    test "works for floats" do
      1536.0.strfbytes.assert == "1.50 KB"
      0.5.strfbytes.assert == "0.5 bytes"
    end

    test "works for negative numbers" do
      -1.strfbytes.assert == "-1 byte"
      -1536.strfbytes.assert == "-1.50 KB"
    end

  end

end
