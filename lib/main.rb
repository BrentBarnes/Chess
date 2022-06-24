
require 'colorize'
require 'pry'
require 'json'
require_relative 'main'
require_relative 'game'
require_relative 'board'
require_relative 'white_team'
require_relative 'black_team'
require_relative 'cell'
require_relative 'null_cell'
require_relative 'piece'
require_relative 'move_manager'
require_relative 'ui'
require_relative 'graveyard'
require_relative 'check_manager'
require_relative 'piece_subclasses/pawn'
require_relative 'piece_subclasses/empty_space'
require_relative 'piece_subclasses/rook'
require_relative 'piece_subclasses/knight'
require_relative 'piece_subclasses/bishop'
require_relative 'piece_subclasses/queen'
require_relative 'piece_subclasses/king'
require_relative 'piece_subclasses/red_circle'
require_relative 'piece_subclasses/red_background'

game = Game.new

game.play