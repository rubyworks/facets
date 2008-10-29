module Enumerable

  unless defined?(group_by) or defined?(::ActiveSupport)  # 1.9 or ActiveSupport

    # #group_by is used to group items in a collection by something they
    # have in common.  The common factor is the key in the resulting hash, the
    # array of like elements is the value.
    #
    #   (1..5).group_by { |n| n % 3 }
    #        #=> { 0 => [3], 1 => [1, 4], 2 => [2,5] }
    #
    #   ["I had", 1, "dollar and", 50, "cents"].group_by { |e| e.class }
    #        #=> { String => ["I had","dollar and","cents"], Fixnum => [1,50] }
    #
    #  CREDIT: Erik Veenstra

    def group_by #:yield:
      #h = k = e = nil
      r = Hash.new
      each{ |e| (r[yield(e)] ||= []) << e }
      r
    end

  end

end

