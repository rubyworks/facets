require 'benchmark'

# Load check all libs.

def test_load

  while !File.directory?('lib/core/facets') do
    Dir.chdir('..')
  end

  abort "Can't find project root." unless File.directory?('lib/core/facets')

  @scripts = {}

  Dir.chdir('lib/core') do
    @scripts[:core] = Dir.glob('facets/*.rb')
    @scripts[:core].uniq!
  end

  Dir.chdir('lib/lore') do
    @scripts[:lore] = Dir.glob('facets/*.rb')
    @scripts[:lore].uniq!
  end

  Dir.chdir('lib/more') do
    @scripts[:more] = Dir.glob('facets/*.rb')
    @scripts[:more].uniq!
  end

  $:.unshift('lib/core')
  $:.unshift('lib/lore')
  $:.unshift('lib/more')

  $VERBOSE = nil

  Benchmark.bm do |x|
    x.report("core"){ require_scripts(:core) }
    x.report("lore"){ require_scripts(:lore) }
    x.report("more"){ require_scripts(:more) }
  end
end

def require_scripts(key)
  @scripts[key].each do |file|
    begin
      require file
    rescue Exception => e
      puts file
      puts e.message
    end
  end
end

if $0 == __FILE__
  test_load
end
