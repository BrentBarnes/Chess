
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

def start_game
  introduction
  loop do
    response = gets.chomp
    if response == 'load'
      binding.pry
      old_game = Game.load_game
      old_game.load_graveyard
      old_game.board_from_fen
      old_game.play
    elsif response.to_i == 1
      Game.new.play
      break
    end
  end
end

def introduction
  system('clear')
  puts "Welcome to Chess!"
  puts
  puts "Each turn will be played in two different steps."
  puts
  puts "Step One:"
  puts "Enter the coordinates of the piece you want to move, like 'a1' or 'g7'."
  puts
  puts "Step Two:"
  puts "Enter the coordinates of any legal move or enemy piece you'd like to capture."
  puts
  puts "To begin press 1 followed by Enter."
  puts
  puts "Or type 'load' to load your previously saved game."
end

start_game