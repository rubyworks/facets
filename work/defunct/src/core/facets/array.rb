# Load all Array core extensions.

if RUBY_VERSION < '1.9'
<%=
  path = __FILE__.chomp('.rb')
  base = File.basename(path)
  Dir[File.join(path, '*.rb')].map do |lib|
    %Q{  require "facets/#{base}/#{File.basename(lib)}"}
  end.sort.join("\n")
%>
else
<%=
  path = __FILE__.chomp('.rb')
  base = File.basename(path)
  Dir[File.join(path, '*.rb')].map do |lib|
    %Q{  require_relative "#{base}/#{File.basename(lib)}"}
  end.sort.join("\n")
%>
end


# OLD WAY
#dir, base = *File.split(__FILE__)
#base = base.chomp('.rb')
#Dir[File.join(dir, base, '*.rb')].each do |lib|
#  require "facets/#{base}/#{File.basename(lib)}"
#end

