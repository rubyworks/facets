#!/usr/bin/env ruby
# frozen_string_literal: true

# Build the dependency-free, static GitHub Pages site from the HTML fragments
# in _src. Run from anywhere with: ruby docs/build.rb
require 'erb'

site_dir = __dir__
source_dir = File.join(site_dir, '_src')
layout = ERB.new(File.read(File.join(source_dir, 'layout.erb')), trim_mode: '-')

pages = {
  'index' => ['Ruby Facets | More of Ruby, one method at a time',
              'Ruby Facets adds focused extensions to Ruby core classes and the standard library.'],
  'learn' => ['Guide | Ruby Facets',
              'Install Ruby Facets and choose exactly which extensions to load.'],
  'news' => ['Releases | Ruby Facets',
             'Recent Ruby Facets releases and the historical news archive.'],
  'source' => ['Contribute | Ruby Facets',
               'Explore the source, report issues, and contribute to Ruby Facets.']
}

pages.each do |slug, (title, description)|
  content = File.read(File.join(source_dir, "#{slug}.erb"))
  active = slug
  root = ''
  output = layout.result(binding)
  File.write(File.join(site_dir, "#{slug}.html"), output)
end

# Historical posts keep their original article copy, but use today's site shell.
archive = {
  '2008-01-01-how-facets-was-born' => 'How Facets Was Born',
  '2008-03-24-release-2-4' => 'Facets 2.4.3',
  '2009-07-21-new-website' => 'New Website with Jekyll',
  '2009-08-22-release-2-7' => 'Facets 2.7 is a Significant Release',
  '2009-11-09-release-2-8' => 'Facets 2.8 Release',
  '2010-09-01-release-2-9' => 'Facets 2.9 Release'
}

archive.each do |slug, post_title|
  body = File.read(File.join(source_dir, 'archive', "#{slug}.html"))
  date = slug[0, 10]
  title = "#{post_title} | Ruby Facets archive"
  description = "#{post_title}, a historical post from the Ruby Facets archive."
  active = 'news'
  root = '../'
  content = <<~HTML
    <section class="page-hero archive-hero"><div class="shell"><p class="eyebrow"><span class="eyebrow-line"></span> FROM THE ARCHIVE / #{date}</p><h1>#{post_title}</h1><p>This post is preserved from an earlier Facets release. For current installation and API guidance, use the <a href="../learn.html">guide</a>.</p></div></section>
    <article class="archive-article shell">#{body}</article>
    <div class="archive-back shell"><a class="text-link" href="../news.html">← All releases and archives</a></div>
  HTML
  output = layout.result(binding)
  File.write(File.join(site_dir, 'posts', "#{slug}.html"), output)
end
