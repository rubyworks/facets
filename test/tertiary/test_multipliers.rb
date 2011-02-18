require 'facets/multipliers.rb'

TestCase Fixnum do

  unit :deka do
    1.deka.assert == 10
  end

  unit :hecto do
    1.hecto.assert == 100
  end

  unit :kilo do
    1.kilo.assert == 1000
  end

  unit :mega do
    1.mega.assert == 1000000
  end

  unit :giga do
    1.giga.assert == 1000000000
  end

  unit :tera do
    1.tera.assert == 1000000000000
  end

  unit :peta do
    1.peta.assert == 1000000000000000
  end

  unit :exa do
    1.exa.assert == 1000000000000000000
  end

  # Fractional

  unit :deci do
    1.deci.assert == 0.1
  end

  unit :centi do
    1.centi.assert == 0.01
  end

  unit :milli do
    1.milli.assert == 0.001
  end

  unit :micro do
    1.micro.assert == 0.000001
  end

  unit :nano do
    1.nano.assert == 0.000000001
  end

  unit :pico do
    1.pico.assert == 0.000000000001
  end

  unit :femto do
    1.femto.assert == 0.000000000000001
  end

  unit :atto do
    1.atto.assert == 0.000000000000000001
  end

  # SI Binary

  unit :kibi do
    1.kibi.assert == 1024
  end

  unit :mebi do
    1.mebi.assert == 1024**2
  end

  unit :gibi do
    1.gibi.assert == 1024**3
  end

  unit :tebi do
    1.tebi.assert == 1024**4
  end

  unit :pebi do
    1.pebi.assert == 1024**5
  end

  unit :exbi do
    1.exbi.assert == 1024**6
  end

end

