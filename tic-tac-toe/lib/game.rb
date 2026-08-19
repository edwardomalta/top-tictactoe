# Turistas europeistas
require_relative("display")

# For managing the game logic of tic-tac-toe
class Game
  attr_reader :board
  attr_accessor :winner

  def initialize
    @display = Display.new
    @player1 = "X"
    @player2 = "O"
    @counter = 1
    set_board
  end

  def make_move(position)
    index = position_to_index(position)
    return unless valid_move?(index)

    @board[index] = current_player
    update_winner
  end

  def make_lines
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontals
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # verticals
      [0, 4, 8], [2, 4, 6]             # diagonals
    ].map do |line|
      line.map { |index| @board[index] }
    end
  end

  def update_winner
    return unless @board

    lines = make_lines
    return unless lines.any? { |line| %w[XXX OOO].include?(line.join) }
    lines.each do |line|
      if line.join == "OOO"
        @winner = "O"
      elsif line.join == "XXX"
        @winner = "X"
      end
    end
  end

  def get_player_move
    loop do
      print "Jugador #{current_player} escribe una coordenada para mover:"
      move = gets.chomp
      unless valid_move?(position_to_index(move))
        puts "Movimmiento invalido"
        next
      end
      return move
    end
  end

  def current_player
    @counter.odd? ? @player1 : @player2
  end

  def game_over?
    !@winner.nil? or game_tie?
  end

  def start
    loop do
      make_move(get_player_move)
      @display.show_board @board
      if game_over?
        announce_winner
        break
      end
      @counter += 1
    end
  end

  def announce_winner
    return unless game_over?
    if game_tie?
      puts "Empataron"
    else
      puts "El ganador es #{@winner}"
    end
  end

  def game_tie?
    @board.none?(" ")
  end

  private

  def set_board
    @board = Array.new(9, " ")
  end

  def position_to_index(position)
    column = position[0].upcase.ord - "A".ord
    row = position[1].to_i - 1
    (row * 3) + column
  end

  def valid_move?(index)
    index.between?(0, 8) && @board[index] == " " && @board.any?(" ")
  end
end
