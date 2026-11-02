# Hide the deprecation warnings that the test and demo runs expect.
#
# The tests and demos of deprecated methods call those methods on purpose, and
# each call prints a warning, which buries any warning that matters. This hides
# a Facets deprecation warning unless it was raised from inside lib/: one from
# there means Facets itself calls a deprecated method, which is a bug worth
# seeing.
#
# Loaded by etc/test.rb (rubytest) and demo/applique (QED). Set
# FACETS_DEPRECATIONS=show to see every warning.

unless ENV['FACETS_DEPRECATIONS'] == 'show'
  module QuietFacetsDeprecations
    DEPRECATION = /: warning: .+ is deprecated\. .*It will be removed after \d{4}-\d{2}-\d{2}\./m
    LOCATION    = /\A(.+?):\d+: warning: /
    LIB         = File.join(File.expand_path('../lib', __dir__), '')

    @hidden = 0

    class << self
      attr_accessor :hidden

      def expected?(message)
        return false unless DEPRECATION.match?(message)
        location = message[LOCATION, 1]
        !(location && File.expand_path(location).start_with?(LIB))
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
