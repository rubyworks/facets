
class Hash

  # Alias #slice to #values_at.
  #
  #   h = { :a => 1, :b => 2, :c => 3 }
  #   h.slice(:a)      #=> [1]
  #   h.slice(:a, :b)  #=> [1,2]

  alias_method(:slice, :values_at)

  # Adds slicing to Hash#[]. If more than one key arguments
  # is given to <tt>Hash#[]</tt>, the return value will be
  # an array of the corresponding values.
  #
  #   h = { :a => 1, :b => 2, :c => 3 }
  #   h[:a]            #=> 1
  #   h[:a, :b]        #=> [1,2]

  def []( *sliceKeys )
    if sliceKeys.length == 1
      return at( sliceKeys[0] )
    else
      return values_at( *sliceKeys )
    end
  end

  # Add slicing to element assignment operator.
  #
  #   h = {:a=>1, :b=>2, :c=>3}
  #
  #   h[:a] = 9              #=> 9
  #   h                      #=> {:a=>9, :b=>2, :c=>3}
  #
  #   h[:a, :c] = [10,11]    #=> [10,11]
  #   h                      #=> {:a=>10, :b=>2, :c=>11}

  def []=( *args )
    if args.length <= 2
      return store( *args )
    end
    aVals = args.pop
    aVals = [aVals] unless aVals.kind_of?( Array )
    args.each_index{ |i| store( args[i], aVals[i] ) }
  end


end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TestHashSlice < Test::Unit::TestCase

    @hash = nil
    AryKey = %w{an array as a key}
    AryVal = %w{an array as a value}

    def setup
      @hash = {
        "this" => "is",
        "a" => "test",
        "hash" => "with",
        "some" => "values",
        "for" => "testing",
        AryKey => 'aryKey',
        'aryVal' => AryVal
      }
    end

    # Testing teardown method
    def teardown
      @hash = nil
    end

    # Make sure we haven't screwed up regular element reference
    def test_get_regular
        assert_equal('is', @hash['this'])
        assert_equal('aryKey', @hash[ AryKey ])
        assert_equal(AryVal, @hash[ 'aryVal' ])
        assert_nil(@hash['nonExistant'])
    end

    # Test slice reference
    def test_get_2args
      res = @hash['this','a']
      assert_instance_of( Array, res )
      assert_equal( ['is','test'], res )

      assert_equal(['aryKey','with'], @hash[ AryKey, 'hash' ])

      assert_equal([AryVal,'testing'], @hash[ 'aryVal', 'for' ])

      assert_equal(['aryKey',AryVal], @hash[ AryKey, 'aryVal' ])

      res = @hash['nonExistant', 'anotherNonExistant']
      assert_nil(res[0])
      assert_nil(res[1])

      @hash.default = 'default'
      res = @hash['nonExistant', 'anotherNonExistant']
      assert_equal( 'default', res[0] )
      assert_equal( 'default', res[1] )
    end

    # Test fetching slices with duplicate keys
    def test_get_duplicate_args
      assert_equal(['is','is'], @hash['this','this'])
      assert_equal(['aryKey','aryKey'], @hash[ AryKey, AryKey ])
      assert_equal([AryVal,AryVal], @hash[ 'aryVal', 'aryVal' ])
      assert_equal(['aryKey',AryVal,'aryKey','aryKey'], @hash[ AryKey, 'aryVal', AryKey, AryKey ])
    end

    # Test to make sure we haven't mucked up regular element assign
    def test_set_regular
      # Single string key assign
      @hash['this'] = 'something else'
      assert_equal( 'something else', @hash['this'] )

      # Single array key assign
      @hash[AryKey] = 'something else'
      assert_equal( 'something else', @hash[AryKey] )

      # Make sure range-assign behaviour is unchanged
      rng = 1..5
      @hash[ rng ] = 1..5
      assert_instance_of( Range, @hash[rng] )
      assert_equal( 1..5, @hash[1..5] )
    end

    # Test slice-assign
    def test_set_2args
      # Test slice-assign with string keys
      assert_nothing_raised {@hash['this','a'] = 'other', 'stuff'}
      assert_equal( 'other', @hash['this'] )
      assert_equal( 'stuff', @hash['a'] )

      # Test slice-assign with array keys and a string and array value
      assert_nothing_raised {@hash[AryKey, %w{some other array}] = 'another', %w{set of values}}
      assert_equal( 'another', @hash[AryKey] )
      assert_equal( %w{set of values}, @hash[%w{some other array}] )
    end

    def test_slice
      h =  {:a=>1, :b=>2, :c=>3 }
      assert_equal( [1,2], h.slice(:a,:b) )
    end
  end

=end
