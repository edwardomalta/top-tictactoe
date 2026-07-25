require "minitest/autorun"
require_relative "../lib/game"
require_relative "../lib/computer_player"

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

class TestNewDeduceMethod < Minitest::Test
  def test_it_detects_first_try
    game = Game.new
    colors = game.colors
    computer_player = ComputerPlayer.new(colors)
    computer_player.deduce_method

    assert_equal 1, computer_player.intent_number
  end

  def test_it_detects_second_try
    game = Game.new
    game.code = [1, 1, 2, 2]
    colors = game.colors
    computer_player = ComputerPlayer.new(colors)

    # intento 1
    first_try_code = computer_player.deduce_method.dup
    result = game.check_guess(first_try_code).first
    last_number = first_try_code.pop
    computer_player.feedback(result)

    # intento 2
    second_try_code = computer_player.deduce_method.dup
    processed_last_number = second_try_code.pop

    assert_equal 2, computer_player.intent_number
    assert_equal first_try_code, second_try_code
    refute_equal last_number, processed_last_number, "they must be different"
  end
end
