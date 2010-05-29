dir, base = *File.split(__FILE__)
base = base.chomp('.rb').chomp('_case')

Covers "facets/#{base}"

Dir[File.join(dir, base, '*')].each do |test|
  require test
end

