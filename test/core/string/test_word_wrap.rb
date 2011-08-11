covers 'facets/string/word_wrap'

test_case String do

  method :word_wrap do

    test do
      e = "abcde\n12345\nxyzwu\n"
      r = "abcde 12345 xyzwu".word_wrap(5)
      r.assert == e
    end

    test do
      e = "abcd\n1234\nxyzw\n"
      r = "abcd 1234 xyzw".word_wrap(4)
      r.assert == e
    end

    test do
      e = "abc\n123\n"
      r = "abc 123".word_wrap(4)
      r.assert == e
    end

    test do
      e = "abc \n123\n"
      r = "abc  123".word_wrap(4)
      r.assert == e
    end

    test do
      e = "abc \n123\n"
      r = "abc     123".word_wrap(4)
      r.assert == e
    end

    # test do
    #   assert_equal "abcde-\n12345-\nxyzwu\n", "abcde12345xyzwu".word_wrap(6,2)
    #   assert_equal "abcd-\n1234-\nxyzw\n", "abcd1234xyzw".word_wrap(5,2)
    #   assert_equal "abc \n123\n", "abc 123".word_wrap(4,2)
    #   assert_equal "abc \n123\n", "abc  123".word_wrap(4,2)
    #   assert_equal "abc \n123\n", "abc     123".word_wrap(4,2)
    # end
  end

  method :word_wrap! do

    test do
      w = "abcde 12345 xyzwu"
      w.word_wrap!(5)
      w.assert == "abcde\n12345\nxyzwu\n"
    end

    test do
      w = "abcd 1234 xyzw"
      w.word_wrap!(4)
      w.assert == "abcd\n1234\nxyzw\n"
    end

    test do
      w = "abc 123"
      w.word_wrap!(4)
      w.assert == "abc\n123\n"
    end

    test do
      w = "abc  123"
      w.word_wrap!(4)
      w.assert == "abc \n123\n"
    end

    test do
      w = "abc     123"
      w.word_wrap!(4)
      w.assert == "abc \n123\n"
    end

  end

end
