covers 'facets/shellwords'

test_case Shellwords do

  class_method :shellwords do

    test do
      cmd = "ruby my_prog.rb | less"
      Shellwords.shellwords(cmd).assert.instance_of?(Array)
      Shellwords.shellwords(cmd).length.assert == 4
    end

    test "unmatched double quote" do
      bad_cmd = 'one two "three'
      expect ArgumentError do
        Shellwords.shellwords(bad_cmd)
      end
    end

    test "unmatched single quote" do
      bad_cmd = "one two 'three"
      expect ArgumentError do
        Shellwords.shellwords(bad_cmd)
      end
    end

    test "unmatched quotes" do
      bad_cmd = "one '"'"''""'""
      expect ArgumentError do
        Shellwords.shellwords(bad_cmd)
      end
    end

  end

end

test_case Array do

  method :shellwords do
    test do
      e = ["a", "b"]
      a = ["a", "b"].shellwords
      a.assert == e
    end

    test do
      e = ["-d", "a", "b"]
      a = ["a", "b", {:d=>true}].shellwords
      a.assert == e
    end
  end

end

test_case Hash do

  method :shellwords do
    test do
      e = ['--debug']
      a = {:debug=>true}.shellwords
      a.assert == e
    end

    test do
      e = ['--name="jim"', '--debug']
      a = {:debug=>true, :name=>"jim"}.shellwords
      a.each do |x|
        e.assert.include?(x)
      end
    end
  end

end
