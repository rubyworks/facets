= README.txt

Release: 0.1.0

copyright(c) 2007 kuwata-lab.com all rights reserved.


== About

'cgi_exception.rb' is a tiny script to show exception raised in your
CGI script into browser, like PHP. You don't need to look for error
messages in Web server's log file.


== Install

If you have installed RubyGems, just type 'gem install cgi-exception'
with administrator priviledge.

Or, just type 'ruby setup.rb' with administrator priviledge.

Or, copy 'lib/cgi_exception.rb' to proper directory.


== Usage

All you have to do is to require 'cgi_exception'.
If you do so and exception raised, what and where exception raised will
be shown in browser.


== Example

For example, the following code will raise exception at line 4, because
local variable 'user' is not initialized.

    #!/usr/bin/env ruby
    require 'cgi'
    require 'cgi_exception'
    html = "<pp>Hello #{user}!</p>\n"
    print cgi.header
    print html

You'll see the following message in your browser if you access the abobe
CGI script.

    /var/www/cgi-bin/foo.cgi:4: undefined local variable or method `user'
    for main:Object (NameError)


== License

public domain


== Author

makoto kuwata <kwa(at)kuwata-lab.com>
