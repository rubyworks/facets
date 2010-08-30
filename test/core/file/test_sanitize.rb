covers 'facets/file/sanitize'

tests File do

  # TODO: Write file identity tests.
  metaunit :sanitize => "spaces become underscores" do
    File.sanitize('This is a test').assert == "This_is_a_test"
  end

  metaunit :sanitize => "Windows-style path dividers" do
    File.sanitize('This\is\test').assert == "test"
  end

  metaunit :sanitize => "Unix-style path dividers" do
    File.sanitize('This/is/test').assert == "test"
  end

  metaunit :sanitize => "non-word characters" do
    File.sanitize('This/te#$#@!st').assert == "te_____st"
  end

  metaunit :sanitize => "initial dot" do
    File.sanitize('.').assert == "_."
    File.sanitize('....').assert == "_...."
  end

end

