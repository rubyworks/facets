#!/usr/bin/env ruby

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
 
desc "run lore unit tests"
task 'test:lore' do
  prepare_tests_lore
end
 
desc "run more unit tests"
task 'test:more' do
  prepare_tests_more
end

desc "run all unit tests with ActiveSupport loaded"
task 'test:all:activesupport' => [:include_activesupport, 'test:all']

desc "run core unit tests with ActiveSupport loaded"
task 'test:core:activesupport' => [:include_activesupport, 'test:core']

desc "run lore unit tests with ActiveSupport loaded"
task 'test:lore:activesupport' => [:include_activesupport, 'test:lore']

desc "run more unit tests with ActiveSupport loaded"
task 'test:more:activesupport' => [:include_activesupport, 'test:more']

task 'include_activesupport' do
  require 'activesupport'
end


def add_loadpath(*paths)
  live = ENV['live']
 
  unless live
    # $LOAD_PATH.unshift(File.expand_path('lib/core'))
    # $LOAD_PATH.unshift(File.expand_path('lib/lore'))
    # $LOAD_PATH.unshift(File.expand_path('lib/more'))
    paths.each do |path|
      $LOAD_PATH.unshift(File.expand_path(path))
    end
  end
 
  puts "RUBY VERSION: #{RUBY_VERSION}"
  puts "LOAD PATH:\n" + $LOAD_PATH.join("\n")  
end
 
def get_tests(which="{c,l,m}ore")
  if find = ARGV[1..-1].select{|e| e !~ /(^[-]|[=])/ }[0]
    unless FileTest.file?(find)
      #find = File.join(find, '**', 'test_*.rb')
      find = ['test/test_*.rb']
      find << File.join(find, which, '**', 'test_*.rb')
    end
  else
    #find = 'test/**/test_*.rb'
    find = ['test/test_*.rb']
    find << "test/#{which}/**/test_*.rb"
  end
  
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
  add_loadpath('lib/core','lib/lore','lib/more')
  files = get_tests
  run_tests(files)
end

def prepare_tests_core
  add_loadpath('lib/core')
  files = get_tests('core')
  run_tests(files)
end

def prepare_tests_lore
  add_loadpath('lib/lore')
  files = get_tests('lore')
  run_tests(files)
end

def prepare_tests_more
  add_loadpath('lib/more')
  files = get_tests('more')
  run_tests(files)
end


#def run_tests
#  live = ENV['live']
#
#  unless live
#    $LOAD_PATH.unshift(File.expand_path('lib/core'))
#    $LOAD_PATH.unshift(File.expand_path('lib/lore'))
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

