#!/usr/bin/env ruby

require 'fileutils'

#
# CORE TEST COVERAGE
# ----------------------------------------------------------------------------

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


#
# GENERATE RDOCS
# ----------------------------------------------------------------------------

desc "generate rdocs"

task "rdoc" do
  TEMPLATE  = ENV['RDOC_TEMPLATE'] || 'html'
  APIOUT    = "doc/rdoc"

  FileUtils.rm_r(APIOUT)

  system "rdoc -a -S -t'Facets Core API' -T #{TEMPLATE} -m README --op '#{APIOUT}/core' README lib/facets/core"
  system "rdoc -a -S -t'Facets More API' -T #{TEMPLATE} -m README --op '#{APIOUT}/more' README lib/facets/more"
end

#
# RUN TESTS
# ----------------------------------------------------------------------------

task 'default' do
  prepare_tests_all
end

task 'test' do
  prepare_tests_all
end

desc "run all unit tests"
task 'test:all' do
  prepare_tests_all
end

desc "run core unit tests"
task 'test:core' do
  prepare_tests_core
end

desc "run more unit tests"
task 'test:more' do
  prepare_tests_more
end

desc "run all unit tests with ActiveSupport loaded"
task 'test:all:activesupport' => [:include_activesupport, 'test:all']

desc "run core unit tests with ActiveSupport loaded"
task 'test:core:activesupport' => [:include_activesupport, 'test:core']

desc "run more unit tests with ActiveSupport loaded"
task 'test:more:activesupport' => [:include_activesupport, 'test:more']

task 'include_activesupport' do
  require 'activesupport'
end

def add_loadpath(*paths)
  live = ENV['live']

  unless live
    # $LOAD_PATH.unshift(File.expand_path('lib/core'))
    # $LOAD_PATH.unshift(File.expand_path('lib/more'))
    paths.each do |path|
      $LOAD_PATH.unshift(File.expand_path(path))
    end
  end

  puts "RUBY VERSION: #{RUBY_VERSION}"
  puts "LOAD PATH:\n" + $LOAD_PATH.join("\n") if $DEBUG
end

def get_tests(find=nil)
  find = find && File.directory?(find) ? File.join(find, '**/test_*.rb') : find
  find = find || ENV['TESTS'] || 'test/**/test_*.rb'
  Dir.glob(find)
end

def run_tests(files)
  files.each do |file|
    next if File.directory?(file)
    begin
      puts "Loading: #{file}" if $DEBUG
      load(file)
    rescue LoadError
      puts "Error loading: #{file}"
    end
  end
end

def prepare_tests_all
  add_loadpath('lib/core','lib/more')
  files = get_tests
  run_tests(files)
end

def prepare_tests_core
  add_loadpath('lib/core')
  files = get_tests('test/core')
  run_tests(files)
end

def prepare_tests_more
  add_loadpath('lib/more')
  files = get_tests('test/more')
  run_tests(files)
end

#def run_tests
#  live = ENV['live']
#
#  unless live
#    $LOAD_PATH.unshift(File.expand_path('lib/core'))
#    $LOAD_PATH.unshift(File.expand_path('lib/more'))
#  end
#
#  puts "RUBY VERSION: #{RUBY_VERSION}"
#  puts "LOAD PATH:\n" + $LOAD_PATH.join("\n")
#
#  if find = ARGV[1..-1].select{|e| e !~ /(^[-]|[=])/ }[0]
#    unless FileTest.file?(find)
#      find = File.join(find, '**', 'test_*.rb')
#    end
#  else
#    find = 'test/**/test_*.rb'
#  end
#
#  files = Dir.glob(find)
#
#  files.each do |file|
#    next if File.directory?(file)
#    begin
#      puts "Loading: #{file}" if $DEBUG
#      load(file)
#    rescue LoadError
#      puts "Error loading: #{file}"
#    end
#  end
#end

#
# SETUP/INSTALL
# ----------------------------------------------------------------------------

def load_setup
  begin
    require 'setup'
    $setup_installed = true
  rescue LoadError
    $setup_installed = false
    puts "NOTP"
  end
end

private :load_setup

desc "install to ruby site location"
task :install do
  load_setup

  if $setup_installed
    sh "setup.rb all"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end

desc "uninstall from ruby site location"
task :uninstall do
  load_setup

  if $setup_installed
    sh "setup.rb uninstall"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end
