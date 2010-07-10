module Enumerable

  unless method_defined?(:group_by) # 1.9

    # Enumerable#group_by is used to group items in a collection by something
    # they have in common.  The common factor is the key in the resulting hash,
    # the array of like elements is the value.
    #
    #   (1..5).group_by { |n| n % 3 }
    #   #=> { 0 => [3], 1 => [1, 4], 2 => [2,5] }
    #
    #   ["I had", 1, "dollar and", 50, "cents"].group_by { |e| e.class }
    #   #=> { String => ["I had","dollar and","cents"], Fixnum => [1,50] }
    #
    #   {:a=>1, :b=>2, :c=>1}.group_by{ |k,v| v }
    #   #=> { 1=>[[:c,1], [:a,1]], 2=>[[:b,2]] }
    #
    # CREDIT: Erik Veenstra

    def group_by #:yield:
      r = Hash.new
      each{ |e| (r[yield(e)] ||= []) << e }
      r
    end

  end

end

