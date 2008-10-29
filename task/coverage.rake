#!/usr/bin/env ruby

desc "show core unit test coverage"

task 'coverage' do
  core_scripts = []
  cd 'lib/core/facets' do
    core_scripts = Dir['**/*'].reject{ |s| File.directory?(s) }
  end

  core_tests = []
  cd 'test/core' do
    core_tests = Dir['**/*']
  end

  core_tests = core_tests.collect do |t|
    dir, fname = *File.split(t)
    File.join(dir, fname.sub(/^test_/,''))
  end

  diff = core_scripts - core_tests

  # remove core collectives
  diff = diff - %w{
    array.rb binding.rb cattr.rb class.rb comparable.rb dir.rb
    enumerable.rb exception.rb hash.rb file.rb filetest.rb float.rb
    integer.rb kernel.rb matchdata.rb module.rb nilclass.rb
    numeric.rb proc.rb range.rb regexp.rb string.rb symbol.rb
    time.rb unboundmethod.rb
  }

  puts diff.sort.join("\n")
  puts
  puts "#{diff.size} files uncovered."

end

