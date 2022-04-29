
require 'colorize'
require 'pry'
require 'miscellaneous'

class Board
  include Miscellaneous

  attr_accessor :board, :p1_graveyard, :p2_graveyard

  def initialize
    @board = Array.new(8) {Array.new(8) {"   "}}
    @p1_graveyard = []
    @p2_graveyard = []
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
           rows << space.colorize(background: :blue)
        else
          rows << space.colorize(background: :black)
        end
      end
      rows << " #{row_number.to_s}\n"
      row_number -= 1
    end
    puts rows
    puts "   a  b  c  d  e  f  g  h"
  end

  def set_piece(color_letter, piece_name, coordinate)
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)
    piece = create_piece(color_letter, piece_name)

    @board[row][column] = " #{piece} "
  end

  def clear_piece(coordinate)
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)

    @board[row][column] = "   "
  end

  def space_empty?(coordinate)
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)
    empty = '   '
    board[row][column] == empty ? true : false
  end

end