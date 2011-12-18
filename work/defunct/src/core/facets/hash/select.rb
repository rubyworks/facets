class Hash

  unless method_defined?(:select!)

    # In-place version of Hash#select.  The opposite of the built-in
    # Hash#reject!.
    #
    # CREDIT: Gavin Sinclair, Noah Gibbs

    def select!
      reject! { |k,v| not yield(k,v) }
    end

  end

end

