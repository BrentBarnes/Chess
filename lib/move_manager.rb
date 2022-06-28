
require_relative 'main'

class MoveManager
  attr_reader :game
  attr_accessor :board

  def initialize(game, board, check_manager: game.check_manager)
    @game = game
    @board = board
    @check_manager = check_manager
  end

  def valid_moves_for(cell_object)
    piece = cell_object.piece
    case piece
    when King
      valid_king_moves(cell_object)
    when Queen
      valid_queen_moves(cell_object)
    when Rook
      valid_rook_moves(cell_object)
    when Knight
      valid_knight_moves(cell_object)
    when Bishop
      valid_bishop_moves(cell_object)
    when Pawn
      valid_pawn_moves(cell_object)
    end
  end

  def show_valid_moves(cell_object)
    moves_array = valid_moves_for(cell_object)

    moves_array.each do |move|
      cell = board.cell_at(move)
      piece = cell.piece
      board.place_piece(RedCircle.new('red'), move) if cell.empty?
      if cell.occupied?
        cell.content = cell.content.colorize(background: :red)
      end
    end
  end

  def remove_valid_moves(cell_object)
    moves_array = valid_moves_for(cell_object)

    moves_array.each do |move|
      cell = board.cell_at(move)
      piece = cell.piece
      cell.clear_piece_and_content if piece.is_a?(RedCircle)
      if cell.occupied?
        cell.content = cell.color_content(" #{piece} ")
      end
    end
  end

  def valid_moves_empty?(cell_object)
    valid_moves_for(cell_object).empty?
  end

  def valid_king_moves(cell_object)
    potential = surrounding_cells(cell_object)

    potential.filter_map do |cell|
      cell.name unless cell.same_team_on_space?
    end
  end

  def valid_queen_moves(cell_object)
    all_directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_rook_moves(cell_object)
    directions = [:up, :right, :down, :left]

    directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_knight_moves(cell_object)
    potential_cells = cell_object.knight_cells

    potential_cells.filter_map do |cell|
      unless cell.same_team_on_space?
        cell.name
      end
    end
  end

  def valid_bishop_moves(cell_object)
    directions = [:up_right, :down_right, :down_left, :up_left]
    
    directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_pawn_moves(cell_object)

    directions = cell_object.pawn_cells

    directions.filter_map do |direction|
      case direction
      when cell_object.up
        direction.name unless direction.occupied?
      when cell_object.up_2
        direction.name unless !cell_object.pawn_home_row? || cell_object.up.occupied? || cell_object.up_2.occupied?
      when cell_object.up.left
        direction.name if direction.enemy_team_on_space?
      when cell_object.up.right
        direction.name if direction.enemy_team_on_space?
      end
    end
  end

  def valid_moves_in_direction(cell_object, direction)
    valid_moves = []
    next_cell = cell_object.send(direction)

    loop do
      break if next_cell.name.nil?
      break if next_cell.same_team_on_space?
      valid_moves << next_cell.name
      break if next_cell.enemy_team_on_space?
      next_cell = next_cell.send(direction)
    end
    valid_moves
  end

  private

  def all_directions
    [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left]
  end

  def surrounding_cells(cell_object)
    all_directions.filter_map do |direction|
      cell_object.send(direction)
    end
  end
end