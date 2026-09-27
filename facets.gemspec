require_relative 'lib/core/facets/version'

Gem::Specification.new do |s|
  s.name        = 'facets'
  s.version     = Facets::VERSION
  s.summary     = 'The premier collection of extension methods for Ruby.'
  s.description = 'Facets is the premier collection of extension methods for the Ruby ' \
                  'programming language. Facets extensions are unique by virtue of their ' \
                  'atomicity. They are stored in individual files allowing for highly ' \
                  'granular control of requirements. In addition, Facets includes a few ' \
                  'additional classes and mixins suitable to a wide variety of applications.'

  s.authors     = ['Thomas Sawyer']
  s.email       = ['transfire@gmail.com']
  s.homepage    = 'https://rubyworks.github.io/facets'
  s.license     = 'BSD-2-Clause'

  s.required_ruby_version = '>= 3.1'

  s.files = Dir[
    'lib/**/*.rb',
    'LICENSE.txt',
    'README.md',
    'HISTORY.md',
    'CONTRIBUTING.md'
  ]

  s.require_paths = ['lib/core', 'lib/standard', 'lib/rails']

  s.metadata = {
    'source_code_uri' => 'https://github.com/rubyworks/facets',
    'changelog_uri'   => 'https://github.com/rubyworks/facets/blob/main/HISTORY.md'
  }
end
