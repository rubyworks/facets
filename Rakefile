#!/usr/bin/env ruby

require 'fileutils'

#
# GENERATE RDOCS
# ----------------------------------------------------------------------------

desc "generate rdocs"

task "rdoc" do
  TEMPLATE  = ENV['RDOC_TEMPLATE'] || 'html'
  APIOUT    = "site/doc/api"

  FileUtils.rm_r(APIOUT)

  system "rdoc -a -S -t'Facets Core API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/core' README.rdoc lib/facets/core"
  system "rdoc -a -S -t'Facets More API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/more' README.rdoc lib/facets/more"
  system "rdoc -a -S -t'Facets Standard API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/standard' README.rdoc lib/facets/standard"
  system "rdoc -a -S -t'Facets Tertiary API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/tertiary' README.rdoc lib/facets/tertiary"
end

#
# RUN TESTS (requires Lemon)
# ----------------------------------------------------------------------------

task "default" do
  sh "lemon #{lemon_flags} -Ilib/core:lib/more:lib/standard:lib/tertiary test/core test/more test/standard test/tertiary"
end

task "test" do
  if tests = ENV['TESTS']
    sh "lemon #{lemon_flags} -Ilib/core:lib/more:lib/standard:lib/tertiary #{tests}"
  else
    sh "lemon #{lemon_flags} -Ilib/core:lib/more:lib/standard:lib/tertiary test/core test/more test/standard test/tertiary"
  end
end

desc "run all unit tests"
task "test:all" do
  sh "lemon #{lemon_flags} -Ilib/core:lib/more:lib/standard:lib/tertiary test/core test/more test/standard test/tertiary"
end

desc "run core unit tests"
task "test:core" do
  sh "lemon#{lemon_flags}  -Ilib/core test/core"
end

desc "run more unit tests"
task "test:more" do
  sh "lemon #{lemon_flags} -Ilib/core:lib/more test/more"
end

desc "run standard unit tests"
task "test:standard" do
  sh "lemon #{lemon_flags} -Ilib/core:lib/standard test/standard"
end

desc "run tertiary unit tests"
task "test:tertiary" do
  sh "lemon #{lemon_flags} -Ilib/core:lib/standard test/tertiary"
end

desc "run all unit tests with ActiveSupport loaded"
task 'test:all:activesupport' => [:include_activesupport, 'test:all']

desc "run core unit tests with ActiveSupport loaded"
task 'test:core:activesupport' => [:include_activesupport, 'test:core']

desc "run more unit tests with ActiveSupport loaded"
task 'test:more:activesupport' => [:include_activesupport, 'test:more']

desc "run standard unit tests with ActiveSupport loaded"
task 'test:more:activesupport' => [:include_activesupport, 'test:standard']

desc "run tertiary unit tests with ActiveSupport loaded"
task 'test:more:activesupport' => [:include_activesupport, 'test:tertiary']

task 'include_activesupport' do
  require 'activesupport'
end

def lemon_flags
  flags = []
  if ENV['verbose']
    flags << '-v'
  end
  flags.join(' ')
end

#def add_loadpath(*paths)
#  live = ENV['live']
#
#  unless live
#    # $LOAD_PATH.unshift(File.expand_path('lib/core'))
#    # $LOAD_PATH.unshift(File.expand_path('lib/more'))
#    paths.each do |path|
#      $LOAD_PATH.unshift(File.expand_path(path))
#    end
#  end
#
#  puts "RUBY VERSION: #{RUBY_VERSION}"
#  puts "LOAD PATH:\n" + $LOAD_PATH.join("\n") if $DEBUG
#end

#def get_tests(find=nil)
#  find = find && File.directory?(find) ? File.join(find, '**/test_*.rb') : find
#  find = find || ENV['TESTS'] || 'test/**/test_*.rb'
#  Dir.glob(find)
#end

#def run_tests(files)
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

#def prepare_tests_all
#  add_loadpath('lib/core','lib/more', 'lib/tour')
#  files = get_tests
#  run_tests(files)
#end

#def prepare_tests(type)
#  add_loadpath("lib/#{type}")
#  files = get_tests('test/#{type}')
#  run_tests(files)
#end

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
# TEST COVERAGE
# ----------------------------------------------------------------------------

desc "show test coverage"
task "cov" do
  sh "lemon -Ilib/core:lib/more:lib/tour -c test/core test/more test/tour"
end

desc "show core test coverage"
task "cov:core" do
  sh "lemon -Ilib/core -c test/core"
end

desc "show more test coverage"
task "cov:more" do
  sh "lemon -Ilib/more -c test/more"
end

desc "show standard test coverage"
task "cov:tour" do
  sh "lemon -Ilib/standard -c test/standard"
end

desc "show tertiary test coverage"
task "cov:tour" do
  sh "lemon -Ilib/tertiary -c test/tertiary"
end

desc "show core coverage by file name"
task 'cov:file:core' do
  core_scripts = Dir['lib/core/facets/**/*.rb'].reject{ |s| File.directory?(s) }
  core_tests   = Dir['test/core/**/*.rb']

  core_scripts = core_scripts.map do |f|
    md = /lib\/core\/facets\/(.*?)$/.match(f)
    md[1]
  end

  core_tests = core_tests.map do |f|
    md = /test\/core\/(.*?)$/.match(f)
    md[1].sub('/test_', '/')
  end

  diff = core_scripts - core_tests

  # remove core collectives
  diff = diff - %w{
    array.rb binding.rb cattr.rb class.rb comparable.rb dir.rb
    enumerable.rb exception.rb hash.rb file.rb filetest.rb float.rb
    integer.rb kernel.rb matchdata.rb method.rb module.rb nilclass.rb
    numeric.rb object.rb proc.rb process.rb range.rb regexp.rb string.rb
    symbol.rb time.rb unboundmethod.rb
  }

  puts diff.sort.join("\n")
  puts
  puts "#{diff.size} files uncovered."
end


#
# QED
# ----------------------------------------------------------------------------

desc "run qed docs"
task 'qed' do
  sh "qed #{qed_flags} -Ilib/core:lib/more:lib/standard:lib/tertiary qed/core qed/more qed/standard qed/tertiary"
end

desc "run core qed docs"
task 'qed:core' do
  sh "qed #{qed_flags} -Ilib/core qed/core"
end

desc "run more qed docs"
task 'qed:more' do
  sh "qed #{qed_flags} -Ilib/core:lib/more qed/more"
end

desc "run standard qed docs"
task 'qed:standard' do
  sh "qed #{qed_flags} -Ilib/core:lib/standard qed/standard"
end

desc "run tertiary qed docs"
task 'qed:tour' do
  sh "qed #{qed_flags} -Ilib/core:lib/tertiary qed/tertiary"
end

desc "run core qed docs"
task 'qed:code' do
  sh "qed #{qed_flags} -c -Ilib/core lib/core"
end

def qed_flags
  flags = []
  if ENV['verbose']
    flags << '-v'
  end
  flags.join(' ')
end


#
# Extension Clashes
#-----------------------------------------------------------------------------

# TODO: need to fork each lookup via a seprate process to get a clean picture

desc "print method clashes with ActiveSupport"
task 'clash:as' do
  #require 'lemon/model/snapshot'
  #snap1 = Snapshot.new
  #$LOAD_PATH.unshift('lib/core')
  #$LOAD_PATH.unshift('lib/more')
  #$LOAD_PATH.unshift('lib/tour')
  #require 'facets' # 'facets/all'
  #snap2 = Snapshot.new
end

desc "print method clashes with Ruby"
task 'clash:ruby' do
  require 'lemon/model/snapshot'
end


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


#
# CHECK CHERRY PICKING
# ----------------------------------------------------------------------------

namespace :check do

  desc 'check cherry pickability'
  task 'cherry' do
    files = Dir['lib/**/*.rb']
    files.each do |file|
      out = `ruby -Ilib #{file}`
      if out != ''
        puts file
        puts out
      end
    end
  end

end

