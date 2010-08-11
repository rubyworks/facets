# = OpEsc
#
# NOTE: As of v3.0 of Facets these have been renamed:
#
#    op_plus_self   -> op_plus
#    op_minus_self  -> op_minus
#    op_plus        -> op_add
#    op_minus       -> op_sub
#    op_case_eq     -> op_case
#
# TODO: In the future we might also rename:
#
#    op_lshift      -> op_push
#    op_rshift      -> op_pull
#
module OpEsc

  OPERATORS = %w{ +@ -@ + - ** * / % ~ <=> << >> < > === == =~ <= >= | & ^ []= [] }
  OPERATORS_REGEXP = Regexp.new( '(' << OPERATORS.collect{ |k| Regexp.escape(k) }.join('|') << ')' )
  OPERATORS_ESC_TABLE = {
      "+@"   => "op_plus",
      "-@"   => "op_minus",
      "+"    => "op_add",
      "-"    => "op_sub",
      "**"   => "op_pow",
      "*"    => "op_mul",
      "/"    => "op_div",
      "%"    => "op_mod",
      "~"    => "op_tilde",
      "<=>"  => "op_cmp",
      "<<"   => "op_lshift",  #push?
      ">>"   => "op_rshift",  #pull?
      "<"    => "op_lt",
      ">"    => "op_gt",
      "==="  => "op_case",
      "=="   => "op_equal",
      "=~"   => "op_apply",
      "<="   => "op_lt_eq",
      ">="   => "op_gt_eq",
      "|"    => "op_or",
      "&"    => "op_and",
      "^"    => "op_xor",
      "[]="  => "op_store",
      "[]"   => "op_fetch"
  }

  # Applies operator escape's according to OPERATORS_ESCAPE_TABLE.
  #
  #   op_esc('-') #=> "op_minus"
  #
  # CREDIT: Trans

  def self.escape(str)
    str.gsub(OPERATORS_REGEXP){ OPERATORS_ESC_TABLE[$1] }
  end

  #
  def self.method_to_filename(name)
    fname = escape(name)
    fname = fname[0...-1] if fname =~ /[\!\=\?]$/
    fname
  end

  #   # Require a file with puncuation marks escaped.
  #   #
  #   #   require_esc '[].rb'
  #   #
  #   # in actuality requires the file 'op_fetch.rb'.
  #
  #   def require_esc( fpath )
  #     fdir, fname = File.split(fpath)
  #     fname = method_to_filename(fname)
  #     path = File.join(fdir, fname)
  #     require(path)
  #   end

end
