require 'facets/shellwords'
require 'test/unit'

class TestShellwords < Test::Unit::TestCase

  def test_array_shellwords_1
    e = ["a", "b"]
    a = ["a", "b"].shellwords
    assert_equal(e, a)
  end

  def test_array_shellwords_2
    e = ["-d", "a", "b"]
    a = ["a", "b", {:d=>true}].shellwords
    assert_equal(e, a)
  end

  def test_hash_shellwords_1
    e = ['--debug']
    a = {:debug=>true}.shellwords
    assert_equal(e, a)
  end

  def test_hash_shellwords_2
    e = ['--name="jim"', '--debug']
    a = {:debug=>true, :name=>"jim"}.shellwords
    a.each do |x|
      assert(e.include?(x))
    end
  end

end

