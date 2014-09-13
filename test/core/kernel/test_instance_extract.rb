covers 'facets/kernel/instance_extract'
 
test_case Kernel do 

   method :instance_extract do

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
       o.instance_extract('cmd'=>'hello','page'=>'frontpage')
       o.cmd.assert == 'cls'
       o.page.assert == 'frontpage'
     end

   end

 end
