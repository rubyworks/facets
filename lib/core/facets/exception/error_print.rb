class Exception

  # Formats the Exception so that it looks *familiar*,
  # i.e. exactly like your interpreter does it.
  #
  # Port of MRI native `error_print` function.
  #
  # @author Evgeniy Dolzhenko

  def self.error_print(e)
    warn_print = ""
    backtrace = e.backtrace
    backtrace = [ backtrace ] if backtrace.is_a?(String) # 1.9 returns single String for SystemStackError

    warn_print << backtrace[0]
    if e.is_a?(RuntimeError) && e.message.empty?
      warn_print << ": unhandled exception\n"
    else
      if e.message.empty?
        warn_print << ": #{ e.class.name }\n"
      else
        split_message = e.message.split("\n")
        warn_print << ": "
        if split_message.size == 1
          warn_print << "#{ e.message } (#{ e.class.name })\n"
        else
          warn_print << split_message[0]
          warn_print << " (#{ e.class.name })\n"
          warn_print << split_message[1..-1].join("\n").chomp << "\n"
        end
      end
    end

    len = backtrace.size

    ## int skip = eclass == rb_eSysStackError;
    skip = e.is_a?(SystemStackError)

    ## #define TRACE_MAX (TRACE_HEAD+TRACE_TAIL+5)
    ## #define TRACE_HEAD 8
    ## #define TRACE_TAIL 5
    trace_head = 8
    trace_tail = 5
    trace_max = (trace_head + trace_tail + 5)
    ##
    ##	for (i = 1; i < len; i++) {
    i = 1
    while i < len
      ##	    if (TYPE(ptr[i]) == T_STRING) {
      ##		warn_printf("\tfrom %s\n", RSTRING_PTR(ptr[i]));
      ##	    }
      warn_print << "\tfrom %s\n" % e.backtrace[i]

      ##	    if (skip && i == TRACE_HEAD && len > TRACE_MAX) {
      if skip && i == trace_head && len > trace_max
      ##		warn_printf("\t ... %ld levels...\n",
      ##			    len - TRACE_HEAD - TRACE_TAIL);
        warn_print << "\t ... %d levels...\n" % (len - trace_head - trace_tail)
      ##		i = len - TRACE_TAIL;
        i = len - trace_tail
      ##	    }
      end
      ##	}
      i += 1
    end
    warn_print
  end

  # Formats the Exception so that it looks *familiar*,
  # i.e. exactly like your interpreter does it.
  #
  # @author Evgeniy Dolzhenko
  #
  # @todo Anyone have a better name for this method?
  def error_print
    Exception.error_print(self)
  end

end

