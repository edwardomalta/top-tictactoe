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

# My game, my rules!
class TestFeedbackRule < Minitest::Test
  def test_my_rule
    game = Game.new
    game.code = [1, 1, 2, 2]
    player_guess = [1, 1, 1, 1]
    result = game.check_guess(player_guess)
    spected = ["O", "O", "o", "o"]
    assert_equal spected, result[0][:feedback]
  end
end
