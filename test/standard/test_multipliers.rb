covers 'facets/multipliers'

test_case Fixnum do

  method :deka do
    test do
      1.deka.assert == 10
    end
  end

  method :hecto do
    test do
      1.hecto.assert == 100
    end
  end

  method :kilo do
    test do
      1.kilo.assert == 1000
    end
  end

  method :mega do
    test do
      1.mega.assert == 1000000
    end
  end

  method :giga do
    test do
      1.giga.assert == 1000000000
    end
  end

  method :tera do
    test do
      1.tera.assert == 1000000000000
    end
  end

  method :peta do
    test do
      1.peta.assert == 1000000000000000
    end
  end

  method :exa do
    test do
      1.exa.assert == 1000000000000000000
    end
  end

  # Fractional

  method :deci do
    test do
      1.deci.assert == 0.1
    end
  end

  method :centi do
    test do
      1.centi.assert == 0.01
    end
  end

  method :milli do
    test do
      1.milli.assert == 0.001
    end
  end

  method :micro do
    test do
      1.micro.assert == 0.000001
    end
  end

  method :nano do
    test do
      1.nano.assert == 0.000000001
    end
  end

  method :pico do
    test do
      1.pico.assert == 0.000000000001
    end
  end

  method :femto do
    test do
      1.femto.assert == 0.000000000000001
    end
  end

  method :atto do
    test do
      1.atto.assert == 0.000000000000000001
    end
  end

  # SI Binary

  method :kibi do
    test do
      1.kibi.assert == 1024
    end
  end

  method :mebi do
    test do
      1.mebi.assert == 1024**2
    end
  end

  method :gibi do
    test do
      1.gibi.assert == 1024**3
    end
  end

  method :tebi do
    test do
      1.tebi.assert == 1024**4
    end
  end

  method :pebi do
    test do
      1.pebi.assert == 1024**5
    end
  end

  method :exbi do
    test do
      1.exbi.assert == 1024**6
    end
  end

end
