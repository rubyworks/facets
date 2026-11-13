# Hide the deprecation warnings that the test and demo runs expect.
#
# The tests and demos of deprecated methods call those methods on purpose, and
# each call prints a warning, which buries any warning that matters. This hides
# a Facets deprecation warning unless it was raised from inside lib/: one from
# there means Facets itself calls a deprecated method, which is a bug worth
# seeing. The exception is a doc comment in lib/, whose examples `rake
# qed:code` runs, so a deprecated method's own example warns from there.
#
# Loaded by etc/test.rb (rubytest), demo/applique (QED) and `rake qed:code`.
# Set FACETS_DEPRECATIONS=show to see every warning.

unless ENV['FACETS_DEPRECATIONS'] == 'show'
  module QuietFacetsDeprecations
    DEPRECATION = /: warning: .+ is deprecated\. .*It will be removed after \d{4}-\d{2}-\d{2}\./m
    LOCATION    = /\A(.+?):(\d+): warning: /
    LIB         = File.join(File.expand_path('../lib', __dir__), '')

    @hidden = 0

    class << self
      attr_accessor :hidden

      def expected?(message)
        return false unless DEPRECATION.match?(message)
        file, line = LOCATION.match(message)&.captures
        return true unless file
        file = File.expand_path(file)
        !file.start_with?(LIB) || comment?(file, line.to_i)
      end

      def comment?(file, line)
        File.readlines(file)[line - 1].to_s.lstrip.start_with?('#')
      rescue SystemCallError
        false
      end
    end

    def warn(message, *args, **opts)
      if QuietFacetsDeprecations.expected?(message)
        QuietFacetsDeprecations.hidden += 1
        return nil
      end
      super
    end
  end

  Warning.extend(QuietFacetsDeprecations)

  at_exit do
    hidden = QuietFacetsDeprecations.hidden
    if hidden > 0
      $stderr.puts "(#{hidden} expected Facets deprecation warnings hidden; " \
                   "set FACETS_DEPRECATIONS=show to see them)"
    end
  end
end
