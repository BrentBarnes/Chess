
require_relative 'main'

class Coordinate

  attr_accessor :row, :column, :content, :name, :piece, :game
  attr_reader :up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :piece_valid_moves

  def initialize(row, column)
    @row = row
    @column = column
    @content = "   "
    @name = array_to_chess_coord
    @piece = EmptySpace.new
  end

  def clear_piece
    @content = "   "
  end
  
  def array_to_chess_coord
    chess_row = (1 + (7 - row)).to_s
    chess_column = (column + 97).chr
    chess_column + chess_row
  end
  
  def empty?
    content == "   " ? true : false
  end

  def occupied?
    content[1] != ' ' ? true : false
  end

  def ==(other)

  end

  #does this work better in Coordinate or Board
  def in_bounds?
    valid_length = name.length == 2
    valid_row = name[0].between?('a','h')
    valid_column = name[1].between?('1','8')
    valid_length && valid_row && valid_column ? true : false
  end

  def update_piece_and_content(piece_object)
    @piece = piece_object
    @content = " #{piece_object.to_s} "
  end

  def alter_name(space=name, x_adj, y_adj)
    new_row = (space[1].to_i + y_adj).to_s
    new_column = (space[0].ord + x_adj).chr
    new_column + new_row
  end

  def space_up
    coordinate_above = alter_name(name,0,1)
    board.space_at(coordinate_above)
  end

  def all_spaces_in_direction(space, x_adj, y_adj)
    spaces = []
    current = space
    next_space = alter_name(current, x_adj, y_adj)
    until !next_space[0].between?('a','h') || !next_space[1].between?('1','8') 
      current = next_space
      next_space = alter_name(current, x_adj, y_adj)
      spaces << current
    end
    spaces
  end

  def up
    Coordinate.new(row - 1, column)
  end

  def up_right
    Coordinate.new(row - 1, column + 1)
  end

  def right
    Coordinate.new(row, column + 1)
  end

  def down_right
    Coordinate.new(row + 1, column + 1)
  end

  def down
    Coordinate.new(row + 1, column)
  end

  def down_left
    Coordinate.new(row + 1, column - 1)
  end

  def left
    Coordinate.new(row, column - 1)
  end

  def up_left
    Coordinate.new(row - 1, column - 1)
  end
end