require_relative 'lib/display'
require_relative 'lib/game'

display = Display.new

board = ['X', 'O', 'X', ' ', 'X', ' ', 'O', ' ', 'O']

display.show_board(board)

game = Game.new

game.make_move('A1', 'X')
