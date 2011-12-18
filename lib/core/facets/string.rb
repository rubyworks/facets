folder = __FILE__.chomp('.rb')

target = File.basename(folder)

loader = \
  if RUBY_VERSION < '1.9'
    lambda{ |file| require File.join(folder, file) }
  else
    lambda{ |file| require_relative File.join(target, file) }
  end

Dir.entries(folder).each do |file|
  next unless file.end_with?('.rb')
  loader.call(file)
end

