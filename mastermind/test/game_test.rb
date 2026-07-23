require "minitest/autorun"
require_relative "../lib/game"

class PruebaDeEjemplo < Minitest::Test
  def test_dos_mas_dos
    assert_equal 4, 2 + 2
  end

  def test_tres_mas_cuatro
    assert_equal 7, 3 + 4
  end
end
