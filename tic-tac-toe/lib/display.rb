# frozen_string_literal: true

# For displaying the tic-tac-toe board
class Display
  def show_board(board)
    clear_screen
    puts "  A | B | C "
    puts "1 #{board[0]} | #{board[1]} | #{board[2]} "
    puts " ---+---+---"
    puts "2 #{board[3]} | #{board[4]} | #{board[5]} "
    puts " ---+---+---"
    puts "3 #{board[6]} | #{board[7]} | #{board[8]} "
    puts
  end

  def clear_screen
    system("clear") || system("cls")
  end
end
