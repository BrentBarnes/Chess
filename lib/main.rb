
require 'colorize'
require 'pry'
require 'json'
require_relative 'main'
require_relative 'game'
require_relative 'board'
require_relative 'test_board'
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
require_relative 'ui_subclasses/human_vs_human'
require_relative 'ui_subclasses/human_vs_computer'
require_relative 'ui_subclasses/computer_vs_computer'

def full_game
  loop do
    start_game
    rematch = gets.chomp.downcase
    rematch == 'y' ? next : break
  end
  puts "Thanks for playing!"
  exit
end

def start_game
  introduction
  response = gets.chomp
  if response == 'load'
    old_game = Game.load_game
    old_game.load_graveyard
    old_game.board_from_fen
    old_game.play
    start_game if old_game.rematch?
  elsif response.to_i == 1
    game = Game.new.play
  elsif response.to_i == 2
    game = Game.new
    game.ui = HumanVsComputer.new(game, game.board, game.move_manager, game.check_manager)
    game.play
  elsif response.to_i == 3
    game = Game.new
    game.ui = ComputerVsComputer.new(game, game.board, game.move_manager, game.check_manager)
    game.play
    start_game if game.rematch?
  end
end

def introduction
  system('clear')
    puts "#{'Welcome to Chess!'.colorize(:blue).underline}"
    puts
    puts "Each turn will be played in two different steps."
    puts
    puts "#{'Step One:'.colorize(:blue).underline}"
    puts "Enter the coordinates of the piece you want to move, like '#{'a1'.colorize(:blue)}' or '#{'g7'.colorize(:blue)}'."
    puts
    puts "#{'Step Two:'.colorize(:blue).underline}"
    puts "Enter the coordinates of any legal move or enemy piece you'd like to capture."
    puts
    puts "#{'Game Modes:'.colorize(:blue).underline}"
    puts "      Select #{'[1]'.colorize(:blue)} for human vs. human"
    puts "      Select #{'[2]'.colorize(:blue)} for human vs. computer"
    puts "      Select #{'[3]'.colorize(:blue)} for computer vs. computer"
    puts
    puts "Or type '#{'load'.colorize(:blue)}' to load your previously saved game."
end

full_game