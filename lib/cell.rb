
require_relative 'main'

class Cell

  attr_accessor :row, :column, :content, :name, :piece, :game, :board

  def initialize(row, column, game, board)
    @game = game
    @board = board
    @row = row
    @column = column
    @content = color_content("   ")
    @name = array_to_chess_coord
    @piece = EmptySpace.new
  end

  def color_content(string)
    if row % 2 == 0 && column % 2 == 0 ||
      row % 2 == 1 && column % 2 == 1
      string.colorize(background: :blue)
    else
      string.colorize(background: :black)
    end
  end

def update_piece_and_content(piece_object)
    @piece = piece_object
    @content = " #{piece_object.to_s} "
    @content = color_content(content)
  end

  def clear_piece_and_content
    @content = color_content("   ")
    @piece = EmptySpace.new
  end

  def send_piece_to_graveyard
    game.graveyard.send_piece_to_graveyard(piece)
  end
  
  def array_to_chess_coord
    chess_row = (1 + (7 - row)).to_s
    chess_column = (column + 97).chr
    chess_column + chess_row
  end
  
  def empty?
    piece.is_a?(EmptySpace)
  end

  def occupied?
    if empty? || piece.is_a?(RedCircle)
     false
    else
      true
    end
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

  def space_up
    cell_above = alter_name(name,0,1)
    board.cell_at(cell_above)
  end

  def up
    if piece.to_s == '♙'
      board.get(column, row + 1)
    else
      board.get(column, row - 1)
    end
  end

  def up_2
    if piece.to_s == '♙'
      board.get(column, row + 2)
    else
      board.get(column, row - 2)
    end
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
    directions = [up.up.right, right.right.up, right.right.down, down.down.right,
                  down.down.left, left.left.down, left.left.up, up.up.left]

    directions.filter_map { |direction| direction unless direction.name.nil? }
  end

  def pawn_cells
    directions = [up, up_2, up.left, up.right]

    directions.filter_map { |direction| direction unless direction.name.nil? }
  end

  def pawn_attacks
    directions = [up.left, up.right]

    directions.filter_map { |direction| direction.name unless direction.name.nil? || direction.same_team_on_space? }
  end

  def pawn_home_row?
    if piece.to_s == '♟'
      row == 6 ? true : false
    elsif piece.to_s == '♙'
      row == 1 ? true : false
    end
  end
end