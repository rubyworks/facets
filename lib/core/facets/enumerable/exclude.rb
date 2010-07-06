module Enumerable

  unless method_defined?(:exclude?) # 1.9

    # The inverse of #include?.
    #
    def exclude?(object)
      !include?(object)
    end

  end

end
