
require_relative 'miscellaneous'

class Coordinate
  include Miscellaneous

  attr_accessor :row, :column, :content, :name, :piece
  attr_reader :up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left 

  def initialize(row, column)
    @row = row
    @column = column
    @content = "   "
    @name = array_to_chess_coord
    @piece = get_piece_on_space
    @up = alter_name(0,1)
    @up_right = alter_name(1,1)
    @right = alter_name(1,0)
    @down_right = alter_name(1,-1)
    @down = alter_name(0,-1)
    @down_left = alter_name(-1,-1)
    @left = alter_name(-1,0)
    @up_left = alter_name(-1,1)
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

  def alter_name(space=name, x_adj, y_adj)
    new_row = (space[1].to_i + y_adj).to_s
    new_column = (space[0].ord + x_adj).chr
    new_column + new_row
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

end