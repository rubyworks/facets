require 'fileutils'
require 'pathname'

def temporary_directory
  @temporary_directory ||= 'tmp'
end

Before :document do
  if File.exist?(temporary_directory)
    FileUtils.rm_r(temporary_directory)
  end
  FileUtils.mkdir(temporary_directory)
end

When /Given a directory '(.*?)' containing/ do |dir, text|
  #abort unless /^#{temporary_directory}/ =~ dir
  text.lines.each do |file|
    next if file =~ /^\s*$/
    file = File.join(dir, file.strip)
    path = File.dirname(file)
    FileUtils.mkdir_p(path)
    File.open(file, 'w'){ |f| f << "SPINICH" }
  end
end

# Return project root directory by looking for +lib+ directory.
def root_directory
  @root_directory ||= (
    Pathname.new(Dir.pwd).ascend do |root|
      break root if root.join('lib').directory?
    end
  )
end

