require 'facets/paramix.rb'
require 'test/unit'

class TC_Paramix_01 < Test::Unit::TestCase

  module M
    include Paramix

    def f
      mixin_params[M][:p]
    end

    def self.included(base)
      params = base.mixin_params[self]
      base.class_eval do
        define_method :check do
          params
        end
      end
    end
  end

  class C
    include M[:p => "check"]
  end

  class D
    include M[:p => "steak"]
  end

  def test_01_001
    c = C.new
    assert_equal( "check", c.mixin_params[M][:p] )
    assert_equal( "check", c.f )
  end

  def test_01_002
    d = D.new
    assert_equal( "steak", d.mixin_params[M][:p] )
    assert_equal( "steak", d.f )
  end

  def test_01_003
    assert_equal( {M=>{:p => "check"}}, C.mixin_parameters )
    assert_equal( {M=>{:p => "steak"}}, D.mixin_parameters )
  end

  def test_01_004
    c = C.new
    assert_equal( {:p => "check"}, c.check )
    d = D.new
    assert_equal( {:p => "steak"}, d.check )
  end

end

class TC_Paramix_02 < Test::Unit::TestCase

  module M
    # Manually define Paramix method.
    def self.[](parameters)
      Paramix.new(self, parameters) do
        define_method :check do
          mixin_params[M] # or parameters
        end
      end
    end

    def f
      mixin_params[M][:p]
    end
  end

  class C
    include M[:p => "check"]
  end

  class D
    include M[:p => "steak"]
  end

  def test_02_001
    c = C.new
    assert_equal( "check", c.mixin_params[M][:p] )
    assert_equal( "check", c.f )
  end

  def test_02_002
    d = D.new
    assert_equal( "steak", d.mixin_params[M][:p] )
    assert_equal( "steak", d.f )
  end

  def test_02_003
    assert_equal( {M=>{:p => "check"}}, C.mixin_parameters )
    assert_equal( {M=>{:p => "steak"}}, D.mixin_parameters )
  end

  def test_02_004
    c = C.new
    assert_equal( {:p => "check"}, c.check )
    d = D.new
    assert_equal( {:p => "steak"}, d.check )
  end

end

class TC_Paramix_03 < Test::Unit::TestCase

  module M
    include Paramix

    def f
      mixin_params[M][:p]
    end
  end

  class C
    extend M[:p => "mosh"]
  end

  class D
    extend M[:p => "many"]
  end

  def test_03_001
    assert_equal( "mosh", C.f )
  end

  def test_03_002
    assert_equal( "many", D.f )
  end

  def test_03_003
    assert_equal( {M=>{:p => "mosh"}}, (class << C; self; end).mixin_parameters )
    assert_equal( {M=>{:p => "many"}}, (class << D; self; end).mixin_parameters )
  end

end


class TC_Paramix_04 < Test::Unit::TestCase

  module O
    def self.[](parameters)
      Paramix.new(self, parameters) do
        attr_accessor mixin_parameters[O][:name]
      end
    end
  end

  class X
    include O[:name=>"x"]
  end

  def test_attribute
    o = X.new
    assert_nothing_raised{ o.x = 10 }
    assert_equal(10, o.x)
  end

  def test_ancestors
    assert(X.ancestors.include?(X))
    assert(X.ancestors.include?(O))
    assert(X.ancestors.include?(Object))
    assert(X.ancestors.include?(Kernel))
  end

end

