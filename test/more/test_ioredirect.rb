require 'test/unit'
require 'facets/ioredirect'

class TC_IORedirect < Test::Unit::TestCase

  class SimpleStringIO
    attr_reader :str
    def initialize; @str = ''; end
    def write(str); @str << str; end
  end

  def test_redirection
    Thread.abort_on_exception = true
    s = SimpleStringIO.new
    r = IORedirect.redirect($stdout, s) do
      $stdout.puts "testing"
      $stdout.puts "redirection"
    end
    assert_equal("testing\nredirection", s.str)
  end

end

