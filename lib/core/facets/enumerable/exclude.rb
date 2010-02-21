module Enumerable

  unless method_defined?(:exclude?) or defined?(::ActiveSupport)  # 1.9 or ActiveSupport

    # The inverse of #include?.
    #
    def exclude?(object)
      !include?(object)
    end

  end

end
