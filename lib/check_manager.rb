
class CheckManager

  attr_reader :game, :board, :move_manager

  def initialize(game, board, move_manager)
    @game = game
    @board = board
    @move_manager = move_manager
  end

  def valid_moves_for_king(friendly_or_enemy)
    king_cell = board.find_king(friendly_or_enemy)
    moves = move_manager.valid_moves_for(king_cell)
    moves
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

  def moving_into_check?(from_cell, coordinate)
    enemy_moves = valid_attacks_for_team('enemy')
    enemy_moves.include?(coordinate) && board.active_king_on_cell?(from_cell)
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
end