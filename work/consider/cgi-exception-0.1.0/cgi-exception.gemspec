#!/usr/bin/ruby

###
### $Rev$
### $Release: 0.1.0 $
### copyright(c) 2007 kuwata-lab.com all rights reserved.
###

require 'rubygems'

spec = Gem::Specification.new do |s|
  ## package information
  s.name        = "cgi-exception"
  s.author      = "makoto kuwata"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.homepage    = "http://cgi-exception.rubyforge.org/"
  s.summary     = "Utility to display what and where exception raised in CGI script"
  s.description = <<-'END'
  cgi-exception.rb is a tiny utility to display what and where exception raised in CGI script just like PHP.
  You don't need to look for error message in web server's log file.
  END

  ## files
  files = []
  files += Dir.glob('lib/**/*')
  files += %w[README.txt setup.rb]
  s.files       = files
end

# Quick fix for Ruby 1.8.3 / YAML bug   (thanks to Ross Bamford)
if (RUBY_VERSION == '1.8.3')
  def spec.to_yaml
    out = super
    out = '--- ' + out unless out =~ /^---/
    out
  end
end

if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end
