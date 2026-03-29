require_relative 'lib/display'

display = Display.new

board = ['X', 'O', 'X', ' ', 'X', ' ', 'O', ' ', 'O']

display.show_board(board)
