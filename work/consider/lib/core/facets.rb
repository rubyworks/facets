# Dynamically load all core libraries.

# Nah... lets do it statically.
module Facets

  # Libraries to exclude from default require.
  EXTRANEOUS = %w{
    succ.rb
    kernel/autoreload.rb
    kernel/once.rb
    kernel/this.rb
    module/attr_validator.rb
    module/instance_function.rb
    object/instance_eval.rb
    proc/partial.rb
    string/mask.rb
    string/obfuscate.rb
    string/stylize.rb
    string/words.rb
  }

  def self.require
    __DIR__ = File.dirname(__FILE__)
    list = []
    Dir.chdir("#{__DIR__}/facets") do
      list = Dir['**/*']
      list.reject!{ |d| File.directory?(d) }
    end
    list -= EXTRANEOUS
    list = list.map{ |f| File.join('facets', f) }
    list.each{ |f| p f; Kernel.require(f) }
  end

end

Facets.require

