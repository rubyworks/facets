# to run both groups
# $ bundle exec guard

# to run just qed demos
# $ bundle exec guard -g qed

# to run just tests
# $ bundle exec guard -g test

PATH = "lib/core:lib/standard"
# the double-colons below are *required* for inline Guards!!!

module ::Guard
  class Qed < Plugin
    def run_all
      puts 'Running all demos'
      puts `qed -I#{PATH} demo`
    end

    def run_on_modifications(paths)
      puts "Running demo for #{paths}"
      puts `qed -I#{PATH} #{paths.join(' ')}`
    end
  end
end

module ::Guard
  class Rubytest < Plugin

    def run_all
      puts 'Running all tests'
      puts `ruby-test test`
    end

    def run_on_modifications(paths)
      puts "Running test for #{paths.join(' ')}"
      puts `ruby-test #{paths.join(' ')}`
    end
  end
end

group :qed do
  guard :qed do
    watch('demo/applique/') { 'demo' }
    watch(%r{^lib/(.+)/facets/(.+\.rdoc)$}) { |m| "demo/#{m[1]}/#{m[2]}" }
    watch(%r{^demo/.+/.+\.rdoc$}) { |m| m[0] }
  end
end

group :test do
  guard :rubytest do
    watch('etc/test.rb') { 'test' }
    watch(%r{^lib/(.+)/facets/(.+\.rb)$}) { |m| "test/#{m[1]}/#{m[2]}" }
    watch(%r{^test/.+/test_.+\.rb$}) { |m| "#{m[0]}" }
  end
end
