
require_relative 'main'

class NullCell

  attr_accessor :row, :column, :content, :name, :piece, :game, :board
  attr_reader :up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :piece_valid_moves

  def initialize
  end

  def clear_piece
  end
  
  def array_to_chess_coord
  end
  
  def empty?
  end

  def occupied?
  end

  def in_bounds?
    false
  end

  def out_of_bounds?
    true
  end

  def same_team_on_space?
    false
  end

  def enemy_team_on_space?
    NullCell.new
  end

  def update_piece_and_content(piece_object)
  end

  def space_up
  end

  def all_spaces_in_direction(space, x_adj, y_adj)
  end

  def up
    NullCell.new
  end

  def up_right
    NullCell.new
  end

  def right
    NullCell.new
  end

  def down_right
    NullCell.new
  end

  def down
    NullCell.new
  end

  def down_left
    NullCell.new
  end

  def left
    NullCell.new
  end

  def up_left
    NullCell.new
  end

  def knight_cells
  end
end