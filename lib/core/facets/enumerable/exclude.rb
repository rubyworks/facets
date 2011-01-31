module Enumerable

  unless method_defined?(:exclude?) # 1.9

    # The inverse of #include?.
    #
    #  [:a, :b].exclude?(:c)  #=> true
    #  [:a, :b].exclude?(:a)  #=> false
    #
    def exclude?(object)
      !include?(object)
    end

  end

end
