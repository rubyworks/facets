covers 'facets/array/divide'

test_case Array do

  method :divide do

    test do
      r = ['a1','b1','a2','b2'].divide(/^a/)
      r.assert == [['a1','b1'],['a2','b2']]
    end

    test do
      r = ['a1','b1','a2','b2'].divide(/^b/)
      r.assert == [['a1'],['b1', 'a2'],['b2']]
    end

    test do
      r = ['a1','b1','a2','b2'].divide(/c/)
      r.assert = [['a1','b1','a2','b2']]
    end

  end

end
watch('app/controllers/application_controller.rb')                         { "spec/controllers" }
watch('config/routes.rb')                                                  { "spec/routing" }
watch(%r{^spec/support/(requests|controllers|mailers|models)_helpers\.rb}) { |m| "spec/#{m[1]}" }
watch(%r{^spec/.+_spec\.rb})

watch(%r{^app/controllers/(.+)_(controller)\.rb})                          { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }

watch(%r{^app/(.+)\.rb})                                                   { |m| "spec/#{m[1]}_spec.rb" }
watch(%r{^lib/(.+)\.rb})
