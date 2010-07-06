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


class TestShellwords2 < Test::Unit::TestCase

  include Shellwords

  def setup
    @not_string = Class.new
    @cmd = "ruby my_prog.rb | less"
  end


  def test_string
    assert_instance_of(Array, shellwords(@cmd))
    assert_equal(4, shellwords(@cmd).length)
  end

  def test_unmatched_double_quote
    bad_cmd = 'one two "three'
    assert_raise ArgumentError do
      shellwords(bad_cmd)
    end
  end

  def test_unmatched_single_quote
    bad_cmd = "one two 'three"
    assert_raise ArgumentError do
      shellwords(bad_cmd)
    end
  end

  def test_unmatched_quotes
    bad_cmd = "one '"'"''""'""
    assert_raise ArgumentError do
      shellwords(bad_cmd)
    end
  end
end

