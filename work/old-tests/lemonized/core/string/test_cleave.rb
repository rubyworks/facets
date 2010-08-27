require 'facets/string/cleave.rb'
require 'test/unit'

class TestStringWords < Test::Unit::TestCase

  def test_cleave_nospaces
    assert_equal [ 'whole', '' ], 'whole'.cleave
    assert_equal [ 'Supercalifragilisticexpialidocious', '' ],
                'Supercalifragilisticexpialidocious'.cleave
  end

  def test_cleave_exact_middle
    assert_equal [ 'fancy', 'split' ], 'fancy split'.cleave
    assert_equal [ 'All good Rubyists', 'know how to party' ],
                'All good Rubyists know how to party'.cleave
  end

  def test_cleave_closer_to_start
    assert_equal [ 'short', 'splitter' ], 'short splitter'.cleave
    assert_equal [ 'Four score and', 'seven years ago...' ],
                'Four score and seven years ago...'.cleave
    assert_equal [ 'abc def', 'ghijklm nop' ],
                'abc def ghijklm nop'.cleave
  end

  def test_cleave_closer_to_end
    assert_equal [ 'extended', 'split' ], 'extended split'.cleave
    assert_equal [ 'abc defghi', 'jklm nop' ],
                'abc defghi jklm nop'.cleave
  end

end
