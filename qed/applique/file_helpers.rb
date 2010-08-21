require 'fileutils'

def temporary_directory
  @temporary_directory ||= 'tmp/qed'
end

When /Given a directory structure containing/ do |text|
  @temporary_directory = 'tmp/qed/multiglob'
  text.lines.each do |file|
    next if file =~ /^\s*$/
    file = File.join(@temporary_directory, file.strip)
    dir  = File.dirname(file)
    FileUtils.mkdir_p(dir)
    File.open(file, 'w'){ |f| f << "SPINICH" }
  end
end

After :document do
  if File.exist?(temporary_directory)
    FileUtils.rm_r(temporary_directory)
  end
  @temporary_directory = 'tmp/qed'
end

