
require_relative 'main'

class Cell

  attr_accessor :row, :column, :content, :name, :piece, :game, :board
  attr_reader :up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :piece_valid_moves

  def initialize(row, column, board)
    @board = board
    @game = Game.new
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

  #does this work better in Cell or Board
  def in_bounds?
    valid_length = name.length == 2
    valid_row = name[0].between?('a','h')
    valid_column = name[1].between?('1','8')
    valid_length && valid_row && valid_column ? true : false
  end

  def out_of_bounds?
    in_bounds? == false ? true : false
  end

  def same_team_on_space?
    piece.same_team?(game.player1_turn?)
  end

  def enemy_team_on_space?
    piece.enemy_team?(game.player1_turn?)
  end

  def update_piece_and_content(piece_object)
    @piece = piece_object
    @content = " #{piece_object.to_s} "
  end

  def space_up
    cell_above = alter_name(name,0,1)
    board.space_at(cell_above)
  end

  #compromised because #alter_name was taken away
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
    board.get(column, row - 1)
  end

  def up_right
    board.get(column + 1, row - 1)
  end

  def right
    board.get(column + 1, row)
  end

  def down_right
    board.get(column + 1, row + 1)
  end

  def down
    board.get(column, row + 1)
  end

  def down_left
    board.get(column - 1, row + 1)
  end

  def left
    board.get(column - 1, row)
  end

  def up_left
    board.get(column - 1, row - 1)
  end

  def knight_cells
    potential_cells = []
    directions = [up&.up&.right, right&.right&.up, right&.right&.down, down&.down&.right,
                  down&.down&.left, left&.left&.down, left&.left&.up, up&.up&.left]

    directions.each do |direction|
      potential_cells << direction.name unless direction.nil?
    end
    potential_cells
  end
end