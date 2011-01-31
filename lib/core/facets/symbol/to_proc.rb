class Symbol

  unless method_defined?(:to_proc)  # 1.8.7+

    # Turn a symbol into a proc calling the method to which it refers.
    #
    #   up = :upcase.to_proc
    #   up.call("hello")  #=> 'HELLO'
    #
    # More useful is the fact that this allows <tt>&</tt>
    # to be used to coerce Symbol into Proc.
    #
    #   %w{foo bar qux}.map(&:upcase)   #=> ["FOO","BAR","QUX"]
    #   [1, 2, 3].inject(&:+)           #=> 6
    #
    # TODO: This will be deprecated as of Ruby 1.9, since it will become standard Ruby.
    #
    # CREDIT: Florian Gross (orignal), Nobuhiro Imai (current)

    def to_proc
      Proc.new{|*args| args.shift.__send__(self, *args)}
    end

    # Old Definition...
    #
    #   def to_proc
    #     proc { |obj, *args| obj.send(self, *args) }
    #   end
    #
  end

end

