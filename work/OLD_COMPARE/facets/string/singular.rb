
class String

  @inflection_rules = []

  def self.inflection_rule( *args ) @inflection_rules << args end
  def self.inflection_rules() @inflection_rules end

  #

  def self.inflection_rules_by_singular
    return @inflection_rules_by_singular if @inflection_rules_by_singular

    sorted = inflection_rules.sort_by{ |b,s,pl| "#{b}#{s}".size }.reverse
    @inflection_rules_by_singular = sorted.collect do |b, s, pl|
      [ /(#{b})#{s}$/, '\1'+"#{pl}" ]
    end
  end

  #

  def self.inflection_rules_by_plural
    return @inflection_rules_by_plural if @inflection_rules_by_plural

    sorted = inflection_rules.sort_by{ |b,s,pl| "#{b}#{pl}".size }.reverse
    @inflection_rules_by_plural = sorted.collect do |b, s, pl|
      [ /(#{b})#{pl}$/, '\1'+"#{s}" ]
    end
  end

  # One argument means singular and plural are the same.

  inflection_rule 'equipment'
  inflection_rule 'information'
  inflection_rule 'money'
  inflection_rule 'species'
  inflection_rule 'series'
  inflection_rule 'fish'
  inflection_rule 'sheep'
  inflection_rule 'moose'

  # USAGE: +inflection_rule+ base, singular, plural
  #
  # IMPORTANT Each base+singular and base+plural should only appear once!

  inflection_rule 'quiz'         , ''     , 'zes'       # quiz
  inflection_rule 'matr'         , 'ix'   , 'ices'      # matrix
  inflection_rule 'vert|ind'     , 'ex'   , 'ices'      # vertex, index
  inflection_rule 'ox'           , ''     , 'en'        # ox
  inflection_rule 'm'            , 'ouse' , 'ice'       # mouse, louse
  inflection_rule 'l'            , 'ouse' , 'ice'       # mouse, louse
  inflection_rule 'x'            , ''     , 'es'        # fix, box
  inflection_rule 'ch'           , ''     , 'es'        # search, switch
  inflection_rule 'ss'           , ''     , 'es'        # process, address
  inflection_rule 'sh'           , ''     , 'es'        # dish, wish
  #inflection_rule 'qu'           , 'y'    , 'ies'       # query, ability, agency
  inflection_rule 'hive'         , ''     , 's'         # archive, hive
  inflection_rule 'sis'          , ''     , 'ses'       # basis, diagnosis
  inflection_rule 't'            , 'um'   , 'a'         # datum, medium, forum
  inflection_rule 'i'            , 'um'   , 'a'         # datum, medium, forum
  inflection_rule 'r'            , 'um'   , 'a'         # datum, medium, forum
  inflection_rule 'potat'        , 'o'    , 'oes'       # potato
  inflection_rule 'buffal'       , 'o'    , 'oes'       # buffalo, tomato
  inflection_rule 'tomat'        , 'o'    , 'oes'       # buffalo, tomato
  inflection_rule 'p'            , 'erson', 'eople'     # person, salesperson
  inflection_rule 'm'            , 'an'   , 'en'        # man, woman, spokesman
  inflection_rule 'c'            , 'hild' , 'hildren'   # child
  inflection_rule 'bu'           , 's'    , 'ses'       # bus
  inflection_rule 'alias'        , ''     , 'es'        # alias
  inflection_rule 'status'       , ''     , 'es'        # status
  inflection_rule 'vir'          , 'us'   , 'i'         # virus
  inflection_rule 'octop'        , 'us'   , 'i'         # octopus
  inflection_rule 'ax'           , 'is'   , 'es'        # axis
  inflection_rule 'cris'         , 'is'   , 'es'        # crisis
  inflection_rule 'test'         , 'is'   , 'es'        # testis
  inflection_rule 'l'            , 'f'    , 'ves'       # half halves
  inflection_rule ''             , 'fe'   , 'ves'       # safe, wife
  inflection_rule 'a'            , 'y'    , 'ys'        # TODO Combine as a|e|i|o|u
  inflection_rule 'e'            , 'y'    , 'ys'        # 
  inflection_rule 'i'            , 'y'    , 'ys'        # 
  inflection_rule 'o'            , 'y'    , 'ys'        # 
  inflection_rule 'u'            , 'y'    , 'ys'        # 
  inflection_rule ''             , 'y'    , 'ies'       # 
  inflection_rule ''             , ''     , 's'         # --catch all--

  # Convert an English word from plurel to singular.
  #
  #   "boys".singular      #=> boy
  #   "tomatoes".singular  #=> tomato
  #

  def singular
    result = self.dup
    self.class.inflection_rules_by_plural.each do |(match, replacement)|
      break if result.gsub!(match, replacement)
    end
    return result
  end

  # Convert an English word from singular to plurel.
  #
  #   "boy".plural     #=> boys
  #   "tomato".plural  #=> tomatoes
  #

  def plural
    return self.dup if /s$/ =~ self
    result = self.dup
    self.class.inflection_rules_by_singular.each do |(match, replacement)|
      break if result.gsub!(match, replacement)
    end
    return result
  end

  # Railism alias for #singular.
  alias_method( :singularize, :singular )

  # Railism alias for #plural.
  alias_method( :pluralize, :plural )

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  # Singular

  class TestStringSingular < Test::Unit::TestCase

    def test_singular_01
      assert_equal "friend" , "friends".singular
    end

    def test_singular_02
      assert_equal "man"    , "men".singular
    end

    def test_singular_03
      assert_equal "girl"   , "girls".singular
    end

    def test_singular_04
      assert_equal "half"   , "halves".singular
    end

    def test_singular_05
      assert_equal "ox"     , "oxen".singular
    end

    def test_singular_06
      assert_equal "forum"  , "fora".singular
    end

    def test_singular_07
      assert_equal "fish"   , "fish".singular
    end

  end

  # Plural

  class TestStringPlural < Test::Unit::TestCase

    def test_plural_01
      assert_equal "friends" , "friend".plural
    end

    def test_plural_02
      assert_equal "men"     , "man".plural
    end

    def test_plural_03
      assert_equal "girls"   , "girl".plural
    end

    def test_plural_04
      assert_equal "halves"  , "half".plural
    end

    def test_plural_05
      assert_equal "oxen"    , "ox".plural
    end

    def test_plural_06
      assert_equal "fora"    , "forum".plural
    end

    def test_plural_07
      assert_equal "fish"    , "fish".plural
    end

  end

=end
