require 'facets/math/cosech'

test_case Math do

  class_method :cosech do
    test do
      Math.cosech(-1.0).assert == 1.0 / Math.sinh(-1.0)
      Math.cosech( 1.0).assert == 1.0 / Math.sinh( 1.0)
    end

    test "check complementarity of cosech and sinh" do
      (Math.cosech(-2.0) * Math.sinh(-2.0)).assert == 1.0
      (Math.cosech(-1.0) * Math.sinh(-1.0)).assert == 1.0
      (Math.cosech( 1.0) * Math.sinh( 1.0)).assert == 1.0
      (Math.cosech( 2.0) * Math.sinh( 2.0)).assert == 1
    end
  end

end
