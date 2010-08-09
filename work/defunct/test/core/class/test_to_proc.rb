require 'facets/class/to_proc.rb'
require 'test/unit'

class TC_Class_ToProc < Test::Unit::TestCase

  Person = Struct.new(:name)

  def test_to_proc
    people = ["joe"].map(&Person)
    assert_equal("joe", people[0].name)
  end

end
