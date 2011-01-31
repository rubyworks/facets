module Math

  unless defined?(lgamma)

    # Logarithmus naturalis of gamma function of +x+
    def self.lgamma(x)
      h  = x + 5.5
      h -= (x + 0.5) * log(h)
      sum  =  1.000_000_000_190_015
      sum += 76.180_091_729_471_46	     / (x + 1.0)
      sum -= 86.505_320_329_416_77	     / (x + 2.0)
      sum += 24.014_098_240_830_91	     / (x + 3.0)
      sum -=  1.231_739_572_450_155	     / (x + 4.0)
      sum +=  0.120_865_097_386_617_9e-2 / (x + 5.0)
      sum -=  0.539_523_938_495_3e-5     / (x + 6.0)
      -h + log(2.506_628_274_631_000_5 * sum / x)
    end

  end

end
