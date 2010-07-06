class Time

  unless method_defined?(:dst_adjustment)

    # Adjust DST
    #
    # TODO: Can't seem to get this to pass ActiveSupport tests,
    # even though it is essentially identical to the ActiveSupport
    # code (see Time#since in time/calculations.rb). It handles
    # all but 4 tests.
    def dst_adjustment(time)
      self_dst = self.dst? ? 1 : 0
      time_dst = time.dst? ? 1 : 0
      seconds  = (self - time).abs
      if (seconds >= 86400 && self_dst != time_dst)
        time + ((self_dst - time_dst) * 60 * 60)
      else
        time
      end
    end

  end

end

