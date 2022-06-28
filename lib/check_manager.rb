
class CheckManager

  attr_reader :game, :move_manager
  attr_accessor :board

  def initialize(game, board, move_manager)
    @game = game
    @board = board
    @move_manager = move_manager
  end

  def valid_moves_for_king(friendly_or_enemy)
    king_cell = board.find_king(friendly_or_enemy)
    moves = move_manager.valid_moves_for(king_cell)

    moves.filter_map do |move|
      move_cell = board.cell_at(move)
      unless  move_cell.same_team_on_space? || 
              moving_into_check?(king_cell, move) ||
              capturing_threatens_king?(move)
        move
      end
    end
  end

  def active_team_check?
    king_moves = valid_moves_for_king('friendly')
    enemy_moves = valid_attacks_for_team('enemy')
    any_safe_spaces = king_moves.any? { |move| !enemy_moves.include?(move) }

    active_king_in_harms_way? && any_safe_spaces ? true : false
  end

  def active_team_checkmate?
    king_moves = valid_moves_for_king('friendly')
    enemy_moves = valid_attacks_for_team('enemy')
    no_safe_spaces = king_moves.all? { |move| enemy_moves.include?(move) }
    
    active_king_in_harms_way? && no_safe_spaces ? true : false
  end

  def draw?
    friendly_pieces = board.find_pieces('friendly')
    enemy_pieces = board.find_pieces('enemy')

    friendly_pieces.length == 1 && enemy_pieces.length == 1 ? true : false
  end

  def moving_into_check?(from_cell, coordinate)
    original_piece = from_cell.piece
    from_cell.clear_piece_and_content

    enemy_moves = valid_attacks_for_team('enemy')
    from_cell.update_piece_and_content(original_piece)

    enemy_moves.include?(coordinate) && board.active_king_on_cell?(from_cell)
  end

  def capturing_threatens_king?(move)
    cell = board.cell_at(move)
    original_piece = cell.piece

    if cell.enemy_team_on_space?
      cell.clear_piece_and_content
      enemy_attacks = valid_attacks_for_team('enemy')
      cell.update_piece_and_content(original_piece)
      return true if enemy_attacks.include?(move)
    end

    false
  end

  def king_safe_cells
    king_moves = valid_moves_for_king('friendly')
    enemy_moves = valid_attacks_for_team('enemy')

    king_moves.filter_map { |move| move unless enemy_moves.include?(move) }
  end

  def find_king_coordinate(friendly_or_enemy)
    king_cell = board.find_king(friendly_or_enemy)
    king_cell.name
  end

  def valid_attacks_for_team(friendly_or_enemy)
    piece_cells = board.find_pieces(friendly_or_enemy)
    game.turn += 1 if friendly_or_enemy == 'enemy'

    all_moves = piece_cells.map do |cell|
      if cell.piece.is_a?(Pawn)
        cell.pawn_attacks
      else
        move_manager.valid_moves_for(cell)
      end
    end
    game.turn -= 1 if friendly_or_enemy == 'enemy'
    all_moves.flatten.uniq.sort
  end

  def active_king_in_harms_way?
    king_coordinate = find_king_coordinate('friendly')
    enemy_moves = valid_attacks_for_team('enemy')

    enemy_moves.include?(king_coordinate)
  end

  def active_king_moving_into_harms_way?(input)
    valid_attacks_for_team('enemy').include?(input)
  end

  def did_not_select_checked_king?(input)
    active_team_check? && input != find_king_coordinate('friendly')
  end
end