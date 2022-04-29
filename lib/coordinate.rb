
require 'miscellaneous'

class Coordinate
  include Miscellaneous

  attr_accessor :row, :column, :content, :name, :piece

  def initialize(row, column)
    @row = row
    @column = column
    @content = "   "
    @name = array_to_chess_coord
    @piece = get_name_of_piece
  end

  def set_piece(color_letter, piece_name)
    piece = create_piece(color_letter, piece_name)
    @content = " #{piece} "
  end

  def clear_piece
    @content = "   "
  end

  def array_to_chess_coord
    chess_row = (1 + (7 - row)).to_s
    chess_column = (column + 97).chr
    chess_column + chess_row
  end

  def space_empty?
    content == "   " ? true : false
  end

  def get_name_of_piece
    symbol = get_piece_on_space
    @@all_pieces.each do |key, value|
      if value == symbol then @piece = key.to_s end
    end
    nil
  end

  def get_piece_on_space
    content[1]
  end

end