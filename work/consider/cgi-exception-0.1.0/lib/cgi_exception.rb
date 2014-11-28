##
## $Rev: 1 $
## $Release: 0.1.0 $
## copyright(c) 2007 kuwata-lab.com all rights reserved.
## License: public domain
##

def _esc_html(s)
  s.to_s.gsub(/&/,'&amp;').gsub(/</,'&lt;').gsub(/>/,'&gt;').gsub(/"/,'&quot;')
end

def _print_stack_trace(ex, out=$stderr, header="Content-Type: text/html\r\n")
  out ||= $stderr
  out << header << "\r\n" if header
  arr = ex.backtrace
  out << "<pre style=\"color:#CC0000\">"
  out << "<b>#{_esc_html arr[0]}: #{_esc_html ex.message} (#{ex.class.name})</b>\n"
  arr[1..-1].each {|s| out << "        from #{_esc_html s}\n" }
  out << "</pre>"
end

at_exit do
  _print_stack_trace($!, $stdout) if $!
end

