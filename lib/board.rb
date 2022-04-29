
require 'colorize'
require 'pry'
require_relative 'miscellaneous'
require_relative 'coordinate'

class Board
  include Miscellaneous

  attr_accessor :board, :coordinate, :p1_graveyard, :p2_graveyard

  def initialize
    @board = Array.new(8) {Array.new(8)}
    @p1_graveyard = []
    @p2_graveyard = []
  end

  def create_board_spaces
    board.each_with_index do |row, row_index|
      row.each_with_index do |space, column_index|
      board[row_index][column_index] = Coordinate.new(row_index, column_index)
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

end

game = Board.new
game.create_board_spaces
game.print_board