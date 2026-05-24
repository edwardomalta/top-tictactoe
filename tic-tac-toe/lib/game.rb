# Turistas europeistas
require_relative("display")

# For managing the game logic of tic-tac-toe
class Game
  attr_reader :board

  def initialize
    @board = Array.new(9, " ")
  end

  def make_move(position, player)
    index = position_to_index(position)
    return unless valid_move?(index)

    @board[index] = player
  end

  private

  def position_to_index(position)
    column = position[0].upcase.ord - "A".ord
    row = position[1].to_i - 1
    (row * 3) + column
  end

  def check_status
    puts "Checando status"
  end

  def valid_move?(index)
    index.between?(0, 8) && @board[index] == " "
  end

  # This is the game loop
  def start
    # check state
    # if new game, set player names;
    # start playing.
    # if playing:
    #   alternatively make a move for every player.
    #   print the board and ask for a move to the next player
    # if finished:
    #    color the letters the color of the winner
    #    print: "Winner is <name of the player>"
    # Ask the player if want to play again or new game (new names) or exit.
    # if want to play: reset all but names.
    # if want a new game ask for the names again.
    # if exit.. exit...
  end
end
