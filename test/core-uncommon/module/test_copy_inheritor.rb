covers 'facets/module/copy_inheritor'

tests Module do

  context "" do
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
    [m1,c1,c2]
  end

  unit :copy_inheritor do |c|
    m1,c1,c2 = c
    m1.koko.assert == [1]
    c1.koko.assert == [1,2,3]
    c2.koko.assert == [1,4]
  end

end

