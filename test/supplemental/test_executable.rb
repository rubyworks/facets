require 'facets/executable'

test_case Executable do

  class SampleCli
    include Executable

    attr :result

    def initialize
      @result = []
    end

    def output=(value)
      @result << "output: #{value}"
    end

    def jump
      @result << "jump"
    end
  end

  #
  method :execute! do
    test "parse without an option" do
      s = SampleCli.new
      s.execute!("jump")
      s.result.assert == ["jump"]
    end

    test "parse with an option" do
      s = SampleCli.new
      s.execute!("jump --output=home")
      s.result.assert == ['output: home', 'jump']
    end
  end

end

