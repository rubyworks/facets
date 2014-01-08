#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

PATH = "lib/core:lib/standard"

metadata = YAML.load_file('.index')
version  = metadata['version']

common_yardopts = %{
  --no-yardopts
  --no-cache
  --title "Ruby Facets"
  --readme README.rdoc
  --protected
  --private
  --tag uncommon:Uncommon
  --tag standard:Standard
}.gsub("\n", ' ')

desc "Generate shomen documentation"
task :document do
  FileUtils.mkdir_p("web/docs/facets-#{version}")
  system "shomen yard #{common_yardopts} lib/core - [A-Z]*.* > web/docs/facets-#{version}/core.json"
  system "shomen yard #{common_yardopts} lib/standard - [A-Z]*.* > web/docs/facets-#{version}/standard.json"
end

=begin
#
# GENERATE RDOCS
# ----------------------------------------------------------------------------

desc "generate rdocs"
task "rdoc" do
  TEMPLATE  = ENV['RDOC_TEMPLATE'] || 'html'
  APIOUT    = "web/docs/rdoc"

  FileUtils.rm_r(APIOUT)

  system "rdoc -a -S -t'Facets Core API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/core' README.rdoc lib/facets/core"
  system "rdoc -a -S -t'Facets Standard API' -T #{TEMPLATE} -m README.rdoc --op '#{APIOUT}/standard' README.rdoc lib/facets/standard"
end
=end

#
# RUN TESTS (requires Lemon)
# ----------------------------------------------------------------------------

task "default" do
  sh "ruby-test #{test_flags} test/"
end

task "test" do
  if tests = ENV['TESTS']
    sh "ruby-test #{test_flags} #{tests}"
  else
    sh "ruby-test #{test_flags} test/"
  end
end

desc "run all unit tests"
task "test:all" do
  sh "ruby-test #{test_flags} test/"
end

desc "run core unit tests"
task "test:core" do
  sh "ruby-test #{test_flags} -Ilib/core test/core"
end

desc "run standard unit tests"
task "test:standard" do
  sh "ruby-test #{test_flags} -Ilib/standard test/standard"
end

desc "run all unit tests with ActiveSupport loaded"
task 'test:all:activesupport' => [:include_activesupport, 'test:all']

desc "run core unit tests with ActiveSupport loaded"
task 'test:core:activesupport' => [:include_activesupport, 'test:core']

desc "run standard unit tests with ActiveSupport loaded"
task 'test:standard:activesupport' => [:include_activesupport, 'test:standard']

task 'include_activesupport' do
  require 'activesupport'
end

def test_flags
  flags = []
  if ENV['verbose']
    flags << '-v'
  end
  flags.join(' ')
end


#
# TEST COVERAGE
# ----------------------------------------------------------------------------

desc "show test coverage"
task "cov" do
  sh "lemon cov -I#{PATH} test"
end

desc "show core test coverage"
task "cov:core" do
  sh "lemon cov -Ilib/core test/core"
end

desc "show standard test coverage"
task "cov:standard" do
  sh "lemon cov -Ilib/standard test/standard"
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
  sh "qed #{qed_flags} -I#{PATH} demo"
end

desc "run core qed docs"
task 'qed:core' do
  sh "qed #{qed_flags} -I#{PATH} demo/core"
end

desc "run standard qed docs"
task 'qed:standard' do
  sh "qed #{qed_flags} -I#{PATH} demo/standard"
end

desc "run core qed from code base"
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
# CHECK CHERRY PICKING
# ----------------------------------------------------------------------------

desc 'check cherry pickability'
task 'check:cherry' do
  files = Dir['lib/**/*.rb']
  files.each do |file|
    out = `ruby -Ilib #{file}`
    if out != ''
      puts file
      puts out
    end
  end
end





#def add_loadpath(*paths)
#  live = ENV['live']
#
#  unless live
#    # $LOAD_PATH.unshift(File.expand_path('lib/core'))
#    # $LOAD_PATH.unshift(File.expand_path('lib/core-uncommon'))
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
#  add_loadpath('lib/core','lib/core-uncommon', 'lib/tour')
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
#    $LOAD_PATH.unshift(File.expand_path('lib/core-uncommon'))
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

