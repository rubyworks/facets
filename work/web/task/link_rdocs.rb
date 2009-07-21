#!/usr/bin/env ruby

# This script creates the documentation links.

links = {
  'core' => [],
  'more' => [],
  'class' => [],
  'mixin' => []
}

links.each do |dir, link|
  dirs = Dir['rdoc/#{dir}/*']

  dirs.sort.each do |c|
    link << %[<a href="#{c}/index.html">#{File.basename(c)}</a> &#160;]
  end
end

p links

