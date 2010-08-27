require 'facets/module/redirect_method'
require 'test/unit'

class Test_Module_RedirectMethod < Test::Unit::TestCase

  def red1 ; 1 ; end

  redirect_method :red2 => :red1

  def test_redirect_red
    assert_equal( 1, red2 )
  end

  # redirect

  def blue1 ; 1 ; end

  redirect :blue2 => :blue1

  def test_redirect_blue
    assert_equal( 1, blue2 )
  end

end

