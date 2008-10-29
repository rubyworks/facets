#!/usr/bin/env ruby

desc "run unit tests"

task 'test' do
  run_tests
end

desc "run unit tests with ActiveSupport loaded"

task 'test:activesupport' do
  require 'activesupport'
  run_tests
end

def run_tests
  live = ENV['live']

  unless live
    $LOAD_PATH.unshift(File.expand_path('lib/core'))
    $LOAD_PATH.unshift(File.expand_path('lib/lore'))
    $LOAD_PATH.unshift(File.expand_path('lib/more'))
  end

  puts "RUBY VERSION: #{RUBY_VERSION}"
  puts "LOAD PATH:\n" + $LOAD_PATH.join("\n")

  if find = ARGV[1..-1].select{|e| e !~ /(^[-]|[=])/ }[0]
    unless FileTest.file?(find)
      find = File.join(find, '**', 'test_*.rb')
    end
  else
    find = 'test/**/test_*.rb'
  end

  files = Dir.glob(find)

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
