covers 'facets/hash/count'

tests Hash do

  unit :count do
    {:A=>1, :B=>1}.count(1).assert == 2
  end

end

