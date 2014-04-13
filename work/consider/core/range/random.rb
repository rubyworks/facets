require 'test/unit'

class Range
  # Give a random number in this range (inclusive -- i.e. includes the endpoints of the range)
  def rand
    self.begin + Kernel.rand(self.end - (self.begin - 1))
  end
end

class RangeTest < Test::Unit::TestCase
  # This depends on the size of the range.
  # It should be large enough for the included numbers.
  NumberOfTrials = 300
  
  def setup
    @data = {}
  end
  
  def observe(value)
    if @data[value]
      @data[value] += 1
    else
      @data[value] = 1
    end
  end
  
  def compile_histogram
    output = ""
    @data.to_a.sort.each do |value, occurrences|
      output << "#{value}:\t#{'#' * occurrences}\n"
    end
    return output
  end
  
  def assert_rand_only_gives_values_in_the_range
    NumberOfTrials.times do
      random_value = @range.rand
      assert(random_value >= @start)
      assert(random_value <= @stop)
    end
  end
  
  def assert_rand_gives_gives_at_least_one_occurrence_of_each_value
    NumberOfTrials.times do
      observe(@range.rand)
    end
    
    if $DEBUG
      puts(compile_histogram)
    end
    
    @range.to_a.each do |value|
      assert(@data[value] >= 1)
    end
  end
  
  def test_rand_with_positive_start
    @start = 5
    @stop = 20
    @range = @start..@stop
    
    assert_rand_only_gives_values_in_the_range
    assert_rand_gives_gives_at_least_one_occurrence_of_each_value
  end
  
  def test_rand_with_negative_start
    @start = -2
    @stop = 5
    @range = @start..@stop
    
    # # If there are occassional errors, this loop can be handy because of the randomness
    # 1000.times do
    #   @data = {}
      assert_rand_only_gives_values_in_the_range
      assert_rand_gives_gives_at_least_one_occurrence_of_each_value
    # end
  end
  
  def test_rand_with_negative_stop
    @start = -20
    @stop = -1
    @range = @start..@stop
    
    # # If there are occassional errors, this loop can be handy because of the randomness
    # 1000.times do
    #   @data = {}
      assert_rand_only_gives_values_in_the_range
      assert_rand_gives_gives_at_least_one_occurrence_of_each_value
    # end
  end
  
  def test_rand_with_floating_point_range_with_positive_start
    @start = 5.5
    @stop = 20.5
    @range = @start..@stop
    
    assert_rand_only_gives_values_in_the_range
  end
  
  def test_rand_with_floating_point_range_with_negative_start
    @start = -2.5
    @stop = 5.5
    @range = @start..@stop
    
    assert_rand_only_gives_values_in_the_range
  end
  
  def test_rand_with_floating_point_range_with_negative_stop
    @start = -20.5
    @stop = -0.5
    @range = @start..@stop
    
    assert_rand_only_gives_values_in_the_range
  end
end