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

  # Facets must not replace Ruby's own escape (issue #67).
  class_method :escape do

    test "escapes shell metacharacters" do
      Shellwords.escape("x; rm -rf ~").assert == "x\\;\\ rm\\ -rf\\ \\~"
    end

    test "escapes glob characters" do
      Shellwords.escape("*.rb ?").assert == "\\*.rb\\ \\?"
    end

  end

end

test_case String do

  method :shellescape do
    test "uses Ruby's escape" do
      "a b*".shellescape.assert == "a\\ b\\*"
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

    test "join them with Ruby's Array#shelljoin" do
      ["a", "b", {:d=>true}].shellwords.shelljoin.assert == "-d a b"
    end
  end

end

# The Array#shelljoin wrapper is a module prepended to Array, so Lemon must
# wrap it there.
test_case Facets::ArrayShelljoin do

  method :shelljoin do
    test "is Ruby's own" do
      %w[ls -l a\ b ;rm].shelljoin.assert == Shellwords.join(%w[ls -l a\ b ;rm])
    end

    test "escapes a nested array or a hash as one argument, as Ruby's does" do
      WarningRecorder.record do
        ['ls', ['-rf', '/']].shelljoin.assert == Shellwords.join(['ls', ['-rf', '/'].to_s])
        ['cmd', {v: true}].shelljoin.assert == Shellwords.join(['cmd', {v: true}.to_s])
      end
    end

    test "warns about a nested array or a hash" do
      warnings = WarningRecorder.record { ['cmd', {v: true}].shelljoin }
      warnings.size.assert == 1
      warnings.first.assert =~ /shellwords\.shelljoin/
    end

    test "doesn't warn about plain strings" do
      WarningRecorder.record { %w[ls -l].shelljoin }.assert == []
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
      {:debug=>true, :name=>"jim"}.shellwords.assert == ['--debug', '--name=jim']
    end

    test "one-letter keys give short flags" do
      {:v=>true, :n=>3}.shellwords.assert == ['-v', '-n=3']
    end

    test "false and nil leave the flag out" do
      {:quiet=>false, :debug=>nil, :v=>true}.shellwords.assert == ['-v']
    end

    test "an array value repeats the flag" do
      {:I=>['lib', 'test']}.shellwords.assert == ['-I=lib', '-I=test']
    end

    test "values aren't quoted, so each word is passed as is" do
      words = {:name=>'a b', :msg=>%q{it's "x"}}.shellwords
      words.assert == ['--name=a b', %q{--msg=it's "x"}]
      Shellwords.split(words.shelljoin).assert == words
    end
  end

  method :shelljoin do
    test do
      {:debug=>true, :name=>'a b'}.shelljoin.assert == '--debug --name\=a\ b'
    end
  end

end
