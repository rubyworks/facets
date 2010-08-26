= Module#copy_inheritor

  require 'facets/module/copy_inheritor'

We see copy_inheritor

    m.koko.assert  == [1]
    c1.koko.assert == [1,2,3]
    c2.koko.assert == [1,4]

    m = Module.new do
      copy_inheritor :koko, []
      koko << 1
    end

    c1 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko << 2
      koko << 3
    end

    c2 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko << 4
    end

copy_inheritor

    m.koko.assert  == [1]
    c1.koko.assert == [1,2,3]
    c2.koko.assert == [1,4]

