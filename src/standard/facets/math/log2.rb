module Math

  INVERSE_LN_2 = 1.0 / ::Math.log(2.0)

  unless defined?(log2)

    # Logarithmus dualis of +x+.
    def self.log2(x)
      Math.log(x) * INVERSE_LN_2
    end

  end

end
