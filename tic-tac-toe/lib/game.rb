# frozen_string_literal: true

# For managing the game logic of tic-tac-toe
class Game
  attr_reader :board

  def initialize
    @board = Array.new(9, ' ')
  end

  def make_move(position, player)
    index = position_to_index(position)
    if valid_move?(index)
      @board[index] = player
      true
    else
      false
    end
  end

  private

  def position_to_index(position)
    column = position[0].upcase.ord - 'A'.ord
    row = position[1].to_i - 1
    row * 3 + column
  end

  def valid_move?(index)
    index.between?(0, 8) && @board[index] == ' '
  end
end
