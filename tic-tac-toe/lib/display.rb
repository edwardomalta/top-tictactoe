# frozen_string_literal: true

# For displaying the tic-tac-toe board
class Display
  def show_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '---+---+---'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '---+---+---'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
end
