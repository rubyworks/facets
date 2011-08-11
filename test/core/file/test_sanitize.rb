covers 'facets/file/sanitize'

test_case File do

  # TODO: Write file identity tests.
  class_method :sanitize do

    test "spaces become underscores" do
      File.sanitize('This is a test').assert == "This_is_a_test"
    end

    test "Windows-style path dividers" do
      File.sanitize('This\is\test').assert == "test"
    end

    test "Unix-style path dividers" do
      File.sanitize('This/is/test').assert == "test"
    end

    test "non-word characters" do
      File.sanitize('This/te#$#@!st').assert == "te_____st"
    end

    test "initial dot" do
      File.sanitize('.').assert == "_."
      File.sanitize('....').assert == "_...."
    end

  end

end

