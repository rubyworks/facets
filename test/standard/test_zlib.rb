covers 'facets/zlib'

test_case Zlib do

  class_method :compress do
    test "round trips with decompress" do
      Zlib.decompress(Zlib.compress("hello " * 10)).assert == "hello " * 10
    end

    test "makes gzip data" do
      Zlib.compress("x").byteslice(0, 2).bytes.assert == [0x1f, 0x8b]
    end
  end

  class_method :decompress do
    test do
      Zlib.decompress(Zlib.compress("abc")).assert == "abc"
    end
  end

  class_method :deflate do
    test "is Ruby's own" do
      Zlib.deflate("abc", Zlib::BEST_SPEED).assert == Zlib::Deflate.deflate("abc", Zlib::BEST_SPEED)
      Zlib.inflate(Zlib.deflate("abc")).assert == "abc"
    end
  end

end
