covers 'facets/object/extract'

test_case Object do

  method :extract do

    test "extracts hash into object" do
      c = Class.new do
        def initialize
          @cmd='cls'
        end
        def cmd
          @cmd
        end
        def page
          @page
        end
      end

      o = c.new
      o.extract({'cmd'=>'hello','page'=>'frontpage'})
      o.cmd.assert == 'cls'
      o.page.assert == 'frontpage'

      o = c.new
      o.extract({'cmd'=>'hello','page'=>'frontpage'},true)
      o.cmd.assert == 'hello'
      o.page.assert == 'frontpage'
    end
  end
end