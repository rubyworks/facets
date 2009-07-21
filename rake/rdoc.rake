#!/usr/bin/env ruby

require 'fileutils'

desc "generate rdocs"

task "rdoc" do
  TEMPLATE  = ENV['RDOC_TEMPLATE'] || 'html'
  APIOUT    = "doc/rdoc"

  FileUtils.rm_r(APIOUT)

  system "rdoc -a -S -t'Facets Core API' -T #{TEMPLATE} -m README --op '#{APIOUT}/core' README lib/facets/core"
  system "rdoc -a -S -t'Facets Lore API' -T #{TEMPLATE} -m README --op '#{APIOUT}/lore' README lib/facets/lore"
  system "rdoc -a -S -t'Facets More API' -T #{TEMPLATE} -m README --op '#{APIOUT}/more' README lib/facets/more"
end

