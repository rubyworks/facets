require 'facets/instantiable.rb'
require 'test/unit'

class TestInstantiable < Test::Unit::TestCase

  module M
    extend Instantiable

    attr :a

    def initialize( a )
      @a = a
    end
  end

  module N
    include Instantiable

    attr :a

    def initialize( a )
      @a = a
    end
  end

  def test_m_new
    m = M.new( 1 )
    assert_equal( 1, m.a )
  end

  def test_n_new
    m = N.new( 1 )
    assert_equal( 1, m.a )
  end

end

