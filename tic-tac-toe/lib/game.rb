# Turistas europeistas
require_relative("display")

# For managing the game logic of tic-tac-toe
class Game
  attr_reader :board

  def initialize
    @display = Display.new
    set_board
  end

  def make_move(position, player)
    index = position_to_index(position)
    return unless valid_move?(index)

    @board[index] = player
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

  def check_winner
    return false unless @board

    lines = make_lines
    false unless lines.any? { |line| %w[XXX OOO].include?(line.join) }

    lines.each do |line|
      if line.join == "OOO"
        @winner = "O"
        return true
      elsif line.join == "XXX"
        @winner = "X"
        return true
      end
    end
  end

  def status
    return unless @display || @board

    @display.show_board @board
    check_winner

    return unless @winner

    puts "The winner is #{@winner}"
  end

  def start
    player1 = "X"
    player2 = "O"
    counter = 1
    loop do
      status
      player = counter.odd? ? player1 : player2

      print "Jugador #{player} escribe una coordenada para mover:"
      move = gets.chomp

      unless valid_move?(position_to_index(move))
        puts "Movimmiento invalido"
        next
      end

      make_move(move, player)

      @display.show_board @board
      status
      counter += 1
      break if @board.none?(" ") || @winner
    end
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

  def check_status
    puts "Checando status"
  end

  def valid_move?(index)
    index.between?(0, 8) && @board[index] == " " && @board.any?(" ")
  end
end
