covers 'facets/module/copy_inheritor'

test_case Module do

  method :copy_inheritor do

    setup do
      m1 = Module.new do
        copy_inheritor :koko, []
        koko << 1
      end
      c1 = Class.new do
        include m1
        #inheritor :koko, [], :+
        koko << 2
        koko << 3
      end
      c2 = Class.new do
        include m1
        #inheritor :koko, [], :+
        koko << 4
      end
      @m1, @c1, @c2 = m1, c1, c2
    end

    test do
      @m1.koko.assert == [1]
      @c1.koko.assert == [1,2,3]
      @c2.koko.assert == [1,4]
    end

  end

end

