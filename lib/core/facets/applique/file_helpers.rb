#
def temporary_directory
  @temporary_directory ||= 'tmp'
end

When /Given a directory '(.*?)' containing/ do |dir, text|
  @temporary_directory = File.join(@temporary_directory, dir)
  text.lines.each do |file|
    next if file =~ /^\s*$/
    file = File.join(@temporary_directory, file.strip)
    dir  = File.dirname(file)
    FileUtils.mkdir_p(dir)
    File.open(file, 'w'){ |f| f << "SPINICH" }
  end
end

Before :all do
  if File.exist?(temporary_directory)
    FileUtils.rm_r(temporary_directory)
  end
  FileUtils.mkdir_p(temporary_directory)
end

# Used for File extensions
When "had a file '(((.*?)))'" do |name|
  name = name.sub(/^tmp\//, '')
  File.open("tmp/#{name}", 'w'){|f| f << "Hello World"}
end

When "had a binary file '(((.*?)))'" do |name|
  name = name.sub(/^tmp\//, '')
  File.open("tmp/#{name}", 'wb'){|f| f << "Hello\nWorld\n"}
end
