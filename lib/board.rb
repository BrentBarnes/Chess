
require 'colorize'

require_relative 'pawn'
require_relative 'empty_space'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'white_team'
require_relative 'black_team'
require_relative 'coordinate'

class Board

  attr_accessor :board, :coordinate, :p1_graveyard, :p2_graveyard

  def initialize
    @main = Main.new
    @board = create_board
    @p1_graveyard = []
    @p2_graveyard = []
  end

  def create_board
    array = Array.new(8) {Array.new(8)}
    array.each_with_index do |row, row_index|
      row.each_with_index do |space, column_index|
        array[row_index][column_index] = Coordinate.new(row_index, column_index)
      end
    end
  end

  def print_board
    
    rows = ""
    
    puts "   a  b  c  d  e  f  g  h"
    row_number = 8
    board.each_with_index do |row, row_index|
      rows << "#{row_number.to_s} "
      row.each_with_index do |space, column_index|
        if row_index % 2 == 0 && column_index % 2 == 0 ||
           row_index % 2 == 1 && column_index % 2 == 1
           rows << space.content.colorize(background: :blue)
        else
          rows << space.content.colorize(background: :black)
        end
      end
      rows << " #{row_number.to_s}\n"
      row_number -= 1
    end
    puts rows
    puts "   a  b  c  d  e  f  g  h"
  end

  def space_at(coordinate)
    board.flatten.find { |space| space.name == coordinate }
  end
  
  def set_pieces_on_board
    white_team = WhiteTeam.new
    black_team = BlackTeam.new

    i = 0
    while i < 16
      place_piece(white_team.pieces[i], white_starting_spaces[i])
      place_piece(black_team.pieces[i], black_starting_spaces[i])
      i += 1
    end
  end

  def place_piece(piece_object, coordinate)
    space = space_at(coordinate)
    space.update_piece_and_content(piece_object)
  end

  def black_starting_spaces
    ['a8','b8','c8','d8','e8','f8','g8','h8',
    'a7','b7','c7','d7','e7','f7','g7','h7']
  end

  def white_starting_spaces
    ['a2','b2','c2','d2','e2','f2','g2','h2',
    'a1','b1','c1','d1','e1','f1','g1','h1']
  end
  
end
