module Math #:nodoc:

  # = Probability & Statistics
  #
  # Provides basic statistical methods, i.e., sum, average, variance,
  # standard deviation, min and max.
  #
  # == Acknowlegements
  #
  #  * Daniel Cutting & David Symonds for statarray.rb
  #
  #
  # TODO: Rename to "Statistics"?
  #
  # TODO: General clean-up. Some of these methods have two implementations, which need to be reduced to 1.
  #
  module Probability

    #
    EPSILON = 0.000000001

    #
	  def float_equal(a, b, epsilon=EPSILON)
		  c = a - b
		  c *= -1.0 if c < 0
      c < epsilon
	  end

    # Returns sum.  When a block is given, summation is taken over the 
    # each result of block evaluation.
    #
    def sum(array) #:yield:
      sum = 0.0
      if block_given?
        array.each{|i| sum += yield(i)}
      else
        array.each{|i| sum += i}
      end
      sum
    end

    # Mean average.
    def mean(array, &blk)
      s = array.size
      return 0.0 if s == 0
      sum(array, &blk) / s
    end

    alias_method :avg, :mean
    alias_method :average, :mean
    alias_method :arithmetic_mean, :mean

    #
    def median(array)
	    return 0 if array.size == 0
	    tmp = array.sort
	    mid = tmp.size / 2
	    if (tmp.size % 2) == 0
		    (tmp[mid-1] + tmp[mid]).to_f / 2
	    else
		    tmp[mid]
	    end
    end
	
    #
    def variance(array, &block)
      sum2 = if block_given?
        sum(array){ |i| j = block[i]; j*j }
      else
        sum(array){ |i| i**2 }
      end
      sum2/array.size - mean(array, &block)**2
    end

    # Variance of the sample.
    #
    def variance2(array)
	    # Variance of 0 or 1 elements is 0.0
	    return 0.0 if array.size < 2
	    summed_sqdevs(array) / (array.size - 1)
    end

    alias_method :var, :variance

    # The sum of the squared deviations from the mean.
    #
    def summed_sqdevs(array)
	    return 0 if array.size < 2
	    m = mean(array)
	    sum(array.map{ |x| (x - m) ** 2 })
    end
	
    # Variance of a population.
    #
    def pvariance
	    # Variance of 0 or 1 elements is 0.0
	    return 0.0 if size < 2
	    summed_sqdevs(array) / array.size
    end

    #
    def standard_deviation(array, &block)
      Math::sqrt(variance(array, &block))
    end

    alias_method :std, :standard_deviation

    # Standard deviation of a sample.
    #
    def stddev(array)
	    Math::sqrt(array, variance2)
    end

    # Standard deviation of a population.
    #
    def pstddev(array)
	    Math::sqrt(array, pvariance)
    end
	
    # Calculates the standard error of this sample.
    def stderr(array)
	    return 0.0 if array.size < 2
	    stddev(array)/Math::sqrt(array.size)
    end
	
    # Returns the confidence interval for this sample as [lower,upper].
    # doc can be 90, 95, 99 or 999, defaulting to 95.
    #def ci(doc = 95)
	  #  limit = climit(doc)
	  #  [mean-limit,mean+limit]
    #end
	
    ## Returns E, the error associated with this sample for the given degree of
    ## confidence.  Where's TTable ?
    #def climit(array, doc=95)
	  #  TTable::t(doc, array.size)*stderr(array)
    #end
	
    # Calculates the relative mean difference of this sample.
    # Makes use of the fact that the Gini Coefficient is half the RMD.
    def relative_mean_difference(array)
	    return 0.0 if Math::float_equal(mean(array), 0.0)
	    gini_coefficient(array) * 2
    end

    alias_method :rmd, :relative_mean_difference
	
    # The average absolute difference of two independent values drawn from
    # the sample. Equal to the RMD * the mean.
    def mean_difference(array)
	    relative_mean_difference(array) * mean(array)
    end

    alias_method :absolute_mean_difference, :mean_difference
    alias_method :md, :mean_difference
	
    # One of the Pearson skewness measures of this sample.
    def pearson_skewness2(array)
	    3 * (mean(array) - median(array)) / stddev(array)
    end
	
    # The skewness of this sample.
    def skewness(array)
	    fail "Buggy"
	    return 0.0 if array.size < 2
	    m = mean
	    s = inject(0){ |sum, xi| sum + (xi - m)**3 }
	    s.to_f / (array.size * variance(array)**(3.0/2) )
    end
	
    # The kurtosis of this sample.
    def kurtosis
	    fail "Buggy"
	    return 0.0 if size < 2
	    m = mean
	    s = 0
	    each { |xi| s += (xi-m)**4 }
	    (s.to_f/((size-1)*variance**2))-3
    end
	
    # Calculates the Theil index (a statistic used to measure economic inequality).
    #
    # TI = \sum_{i=1}^N \frac{x_i}{\sum_{j=1}^N x_j} ln \frac{x_i}{\bar{x}}
    #
    #   http://en.wikipedia.org/wiki/Theil_index
    #
    def theil_index(array)
	    return -1 if array.size <= 0 or any? { |x| x < 0 }
	    return  0 if array.size <  2 or all? { |x| Math::float_equal(x, 0) }
	    m = mean(array)
	    s = sum(array).to_f
	    inject(0) do |theil, xi|
		    theil + ((xi > 0) ? (Math::log(xi.to_f/m) * xi.to_f/s) : 0.0)
	    end
    end
	
    # Closely related to the Theil index and easily expressible in terms of it.
    # http://en.wikipedia.org/wiki/Atkinson_index
    # AI = 1-e^{theil_index}
    def atkinson_index(array)
	    t = theil_index(array)
	    (t < 0) ? -1 : 1-Math::E**(-t)
    end
	
    # Calculates the Gini Coefficient (a measure of inequality of a distribution
    # based on the area between the Lorenz curve and the uniform curve).
    # http://en.wikipedia.org/wiki/Gini_coefficient
    # GC = \frac{1}{N} \left ( N+1-2\frac{\sum_{i=1}^N (N+1-i)y_i}{\sum_{i=1}^N y_i} \right )
    def gini_coefficient2(array)
	    return -1 if size <= 0 or any? { |x| x < 0 }
	    return 0 if size < 2 or all? { |x| Math::float_equal(x,0) }
	    s = 0
	    sort.each_with_index { |yi,i| s += (size - i)*yi }
	    (size+1-2*(s.to_f/sum.to_f)).to_f/size.to_f
    end
	
    # Slightly cleaner way of calculating the Gini Coefficient.  Any quicker?
    # GC = \frac{\sum_{i=1}^N (2i-N-1)x_i}{N^2-\bar{x}}
    def gini_coefficient(array)
	    return -1 if size <= 0 or any? { |x| x < 0 }
	    return 0 if size < 2 or all? { |x| Math::float_equal(x,0) }
	    s = 0
	    sort.each_with_index { |li,i| s += (2*i+1-size)*li }
	    s.to_f/(size**2*mean).to_f
    end
	
    # The KL-divergence from this array to that of q.
    #
    # NB: You will possibly want to sort both P and Q before calling this
    # depending on what you're actually trying to measure.
    #
    # http://en.wikipedia.org/wiki/Kullback-Leibler_divergence
    #
    def kullback_leibler_divergence(array, q)
	    fail "Buggy."
	    fail "Cannot compare differently sized arrays." unless size = q.size
	    kld = 0
	    each_with_index { |pi,i| kld += pi*Math::log(pi.to_f/q[i].to_f) }
	    kld
    end
	
    # Returns the Cumulative Density Function of this sample (normalised to a fraction of 1.0).
    def cdf(array, normalised=1.0)
	    s = sum(array).to_f
	    array.sort.inject([0.0]) { |c,d| c << c[-1] + normalised*d.to_f/s }
    end
      
    #
    def min(array, &block)
      if block_given?
        if min = array.find{ |i| i }
          min = yield(min)
          array.each do |i|
            j = yield(i)
            min = j if min > j
          end
          min
        end
      else
        array.min
      end
    end

    #
    def max(array, block)
      if block_given?
        if max = find{|i| i}
          max = yield(max)
          each{|i|
            j = yield(i)
            max = j if max < j
          }
          max
        end
      else
        array.max
      end
    end

=begin
	    def stats
		    if size != 0
			    return %Q/#{"%12.2f" % sum} #{"%12.2f" % average} #{"%12.2f" % stddev} #{"%12.2f" % min} #{"%12.2f" % max} #{"%12.2f" % median} #{"%12.2f" % size}/
		    else
			    return %Q/<error>/
		    end
	    end
	
	    def to_stats
		    { :sum => sum, :mean => mean, :stddev => stddev, :min => min, :max => max, :median => median, :size => size }
	    end

	    def self.stats_header
		    %Q/#{"%12s" % "Sum"} #{"%12s" % "Avg."} #{"%12s" % "Std.dev."} #{"%12s" % "Min."} #{"%12s" % "Max."} #{"%12s" % "Median"} #{"%12s" % "Size"}/
	    end
=end

  end

  extend  Probability
  include Probability
end


module Enumerable #:nodoc:

  #
  module Probability

    # Generates a hash mapping each unique element in the array
    # to the relative frequency, i.e. the probablity, of
    # it's appearence.
    #
    # CREDIT: Brian Schröder
    #
    def probability
      probs = Hash.new(0.0)
      size = 0.0
      each do | e |
        probs[e] += 1.0
        size += 1.0
      end
      probs.keys.each{ |e| probs[e] /= size }
      probs
    end

    # Old Definition
    #
    #   def probability
    #     arr = self.to_a
    #     probHash = Hash.new
    #     size = arr.size.to_f
    #     arr.uniq.each do |i|
    #       ct = arr.inject(0) do |mem,obj|
    #         obj.eql?(i) ? (mem+1) : mem
    #       end
    #       probHash[i] = ct.to_f/size
    #     end
    #     probHash
    #   end


    # Shannon's entropy for an array - returns the average
    # bits per symbol required to encode the array.
    # Lower values mean less "entropy" - i.e. less unique
    # information in the array.
    #
    #   %w{ a b c d e e e }.entropy  #=>
    #
    # CREDIT: Derek
    #
    def entropy
      arr = to_a
      probHash = arr.probability
      # h is the Shannon entropy of the array
      h = -1.to_f * probHash.keys.inject(0.to_f) do |sum, i|
        sum + (probHash[i] * (Math.log(probHash[i])/Math.log(2.to_f)))
      end
      h
    end

    # Returns the maximum possible Shannon entropy of the array
    # with given size assuming that it is an "order-0" source
    # (each element is selected independently of the next).
    #
    # CREDIT: Derek

    def ideal_entropy
      arr = to_a
      unitProb = 1.0.to_f / arr.size.to_f
      (-1.to_f * arr.size.to_f * unitProb * Math.log(unitProb)/Math.log(2.to_f))
    end

    # Generates a hash mapping each unique symbol in the array
    # to the absolute frequency it appears.
    #
    # CREDIT: Brian Schröder

    def frequency
      #probs = Hash.new(0)
      #each do |e|
      #  probs[e] += 1
      #end
      #probs
      inject(Hash.new(0)){|h,v| h[v]+=1; h}
    end

    # Returns all items that are equal in terms of the supplied block.
    # If no block is given objects are considered to be equal if they
    # return the same value for Object#hash and if obj1 == obj2.
    #
    #   [1, 2, 2, 3, 4, 4].commonality # => { 2 => [2], 4 => [4] }
    #
    #   ["foo", "bar", "a"].commonality { |str| str.length }
    #   # => { 3 => ["foo, "bar"] }
    #
    #   # Returns all persons that share their last name with another person.
    #   persons.collisions { |person| person.last_name }
    #
    # CREDIT: Florian Gross

    def commonality( &block )
      had_no_block = !block
      block ||= lambda { |item| item }
      result = Hash.new { |hash, key| hash[key] = Array.new }
      self.each do |item|
        key = block.call(item)
        result[key] << item
      end
      result.reject! do |key, values|
        values.size <= 1
      end
      #return had_no_block ? result.values.flatten : result
      return result
    end

    # Like commonality but returns an array of duplicates.

    #def collisions(&blk) #:yield:
    #  a = []
    #  commonality(&blk).each{ |k,v| a.concat(v) }
    #  a.uniq
    #end

  end

  include Probability
end


# module String
#
#   NOTE: String#entropy has been deprecated.
#   Use str.chars.entropy instead.
#   def entropy
#     split(//).entropy
#   end
#
#   # Not needed b/c ideal_entropy is only dependent on size.
#   # def ideal_entropy
#   #   self.split(//).ideal_entropy
#   # end
#
# end

