# = TITLE:
#
#   Censor
#
# = DESCRIPTION:
#
#   Reusable class for filtering and rewriting strings.
#
# = AUTHORS:
#
#   - George Moschovitis
#   - Trans
#

# = Censor
#
# Formaly known as TextFilter, this class allows one to define a
# resuable text filter. This is useful for removing or replacing
# cursewords or senstive information from user input.
#
class Censor

  # Abritraty rules.
  attr :rules

  # Word-oriented rules.
  attr :word_rules

  # New Censor object.
  #
  def initialize()
    @rules = []
    @word_rules = []
  end

  # Create new rule. A rule consists of a string or regexp
  # to match against.
  #
  # NOTE: The rules must be applied in order! So we cannot
  # use a hash because the ordering is not guaranteed. So
  # an array is used instead.
  #
  def rule(match, &edit)
    edit = lambda{''} unless edit
    @rules << [match, edit]
  end

  # Rules that apply only to words. This takes the regular
  # expression and add word boundry matches to either side.
  #
  #   filter.word_rule(/damn/){ |w| 'darn' }
  #
  # Is equivalent to teh regular rule:
  #
  #   filter.rule(/\bdamn\b/){ |w| 'darn' }
  #
  def word_rule(match, &edit)
    edit = lambda{''} unless edit
    @word_rules << [/\b#{match}\b/, edit]
  end

  # Apply the set of rules (regular expression matches) to
  # a string.
  #
  def filter(string)
    rewritten_string = string.dup
    rules.each do |match,edit|
      rewritten_string.gsub!(match,edit)
    end
    return (rewritten_string or string)
  end

  alias_method :apply, :filter

  # Is the string clear of any matching rules?
  #
  # Note that running a filter does not necessarily clear a
  # a string of all matches, since the filter could apply
  # edits that would also match the filter expressions.
  #
  def censored?(string)
    case string
    when *matches
      false
    else
      true
    end
  end

  #
  #
  def matches
    rules.collect{ |match, modify| match }
  end

end

