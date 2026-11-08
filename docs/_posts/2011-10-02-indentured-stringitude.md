---
title: Indentured Stringitude
date: 2011-10-02
---

> **Update, November 2026:** Ruby never got a `%L` literal, but Ruby 2.3's squiggly heredoc, `<<~`, strips leading indentation, which takes care of the `help_text` case. In Facets 3.0, `margin` was renamed `trim`, and `margin(n)` took over from `tabto`.

One of the great things about Ruby is the extensive collection of methods
available to the core classes. Of these the String class reigns supreme with
over 100 methods from which to make good use. Among these methods are those we
all use almost every time a string is laid to editor, such as #strip, #+ and #<<.
Others are present that have more specific but important uses, such as #lines, #scan
and #getbyte. There are even a few that can leave one scratching ones head
a bit trying to fathom the usecase, such as #sum.

Yet, despite its wide address, there is a set of methods that have gone
completely overlooked, which is really remarkable when you consider their
purpose, the frequency of their utility and the code savings they provide
when used. These are methods dealing with *indentation*.

It was many years ago when I first was introduced to these three methods by
Gavin Sinclair: #tab, #tabto and #indent. Their interfaces are:

    tab(n)
    Aligns each line n spaces.

    tabto(n)
    Preserves relative tabbing in which the first non-empty line ends up
    with n spaces before non-space.

    indent(n, c=' ')
    Indent left or right by n spaces.

So clearly useful, these were some of the first to make their way in to Ruby
Facets, and they have proven invaluable to me in numerous projects ever since.

Sometime shortly there after, another related method also proved useful at
times, String#margin. It is documented:

    margin(n=0)
    Provides a margin controlled string.

      x = %Q{
            |This
            |  is
            |    margin controlled!
            }.margin

This method is useful largely because it prevents a horrible code smell.
How often have you seen some jutting HERE doc that threw all that nicely
indented Ruby code to the wall.

        def help_text
          <<-HERE
    Usage: foo bar
    -x some option
    -y another option
          HERE
        end

This all too common eye blight was the inspiration for the creation of #margin.
In fact, so confident were Peter and I in this approach to remove these ugly
code-squids that we conceived a %-literal to support such a construct would
be an unimpeachable addition to the language itself, allowing the even more
elegant notation:

    x = %L|Usage: foo bar
          |-x some option
          |-y another option

Such a syntax, being built into Ruby proper, would not suffer the computational
overhead of the pure Ruby implementation, or the extraneous brackets.

In all my years of coding Ruby, it seems to me, these are the clearest
omissions that I have repeatedly found need. And so concluded that they really
should be a part of Ruby proper. And as much as I owe Ruby's String class for all
the time saving methods it provides, in this case, as often as I've had copy and
paste or add a dependency to 'facets' just to get these methods, I think the
String class owes me one!

<!--
title      : String Indenture
author     : trans
categories : [string, ruby]
date       : 2011-10-02
layout     : post
-->
