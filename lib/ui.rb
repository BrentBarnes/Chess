
class UI
  attr_reader :game, :move_manager, :check_manager
  attr_accessor :board

  def initialize(game, board, move_manager, check_manager)
    @game = game
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
  end

  def move_piece
    NotImplementedError
  end

  def human_move_piece
    from_cell = nil
    to_cell = nil

    loop do
      step_1_text
      from_cell = get_player_first_input
      move_manager.show_valid_moves(from_cell)
      step_2_text
      to_cell = get_player_second_input(from_cell)
      move_manager.remove_valid_moves(from_cell)
      if to_cell == 'unselected'
        clear_and_print_board
        next
      end
      break
    end
    
    to_cell.send_piece_to_graveyard if to_cell.occupied?
    update_to_cell_and_clear_from_cell(to_cell, from_cell)
  end

  def get_player_first_input
    loop do
      input = gets.chomp.downcase
      save_game_option(input)
      from_cell = board.cell_at(input)
      invalid_from_selection_responses(from_cell, input)

      next if from_cell.nil? 
      next if from_cell.enemy_team_on_space?
      next if from_cell.empty?
      next if move_manager.valid_moves_empty?(from_cell)
      next if check_manager.did_not_select_checked_king?(input)
      return from_cell
    end
  end

  def get_player_second_input(from_cell)
    valid_moves = move_manager.valid_moves_for(from_cell)

    loop do
      input = gets.chomp.downcase
      to_cell = board.cell_at(input)
      invalid_to_selection_responses(from_cell, to_cell, input)

      break if input == 'unselect'
      next if check_manager.moving_into_check?(from_cell, input)
      next if in_check_if_piece_moves?(from_cell, to_cell)  
      next unless valid_moves.include?(input)
      return to_cell
    end
    'unselected'
  end

  def computer_move_piece
    from_cell = nil
    to_cell = nil

    loop do
      step_1_text
      sleep 0.5
      from_cell = computer_from_selection
      move_manager.show_valid_moves(from_cell)
      step_2_text
      to_cell = computer_to_selection(from_cell)
      sleep 0.5
      move_manager.remove_valid_moves(from_cell)
      next if to_cell == 'unselected'
      break
    end
    
    to_cell.send_piece_to_graveyard if to_cell.occupied?
    update_to_cell_and_clear_from_cell(to_cell, from_cell)
  end

  def computer_from_selection
    loop do
      if check_manager.active_team_check?
        king_space = board.find_king('friendly')
        return king_space
      else
        piece = select_random_friendly_piece
        next if move_manager.valid_moves_empty?(piece)
        return piece
      end
    end
  end

  def computer_to_selection(from_cell)
    valid_moves = move_manager.valid_moves_for(from_cell)

    500.times do
      if check_manager.active_team_check?
        input = check_manager.king_safe_cells.sample
      else
        input = valid_moves.sample
      end
      to_cell = board.cell_at(input)

      next if check_manager.moving_into_check?(from_cell, input)
      next if in_check_if_piece_moves?(from_cell, to_cell)  
      next unless valid_moves.include?(input)
      return to_cell
    end
    'unselected'
  end

  def game_over_text
    if check_manager.draw?
      puts
      puts "It was a draw!".underline
      puts
      puts "Would you like a rematch?"
      puts "Enter '#{'y'.colorize(:blue)}' for yes, or '#{'n'.colorize(:blue)}' for no."
    else
      puts
      puts "Game Over! #{game.non_active_team} Wins!".underline
      puts
      puts "Would you like a rematch?"
      puts "Enter '#{'y'.colorize(:blue)}' for yes, or '#{'n'.colorize(:blue)}' for no."
    end
  end

  private

  def select_random_friendly_piece
    all_friendly_pieces = board.find_pieces('friendly')
    all_friendly_pieces.sample
  end

  def update_to_cell_and_clear_from_cell(to_cell, from_cell)
    to_cell.update_piece_and_content(from_cell.piece)
    from_cell.clear_piece_and_content
  end

  def put_pieces_back(original_to_cell_piece, to_cell, from_cell)
    from_cell.update_piece_and_content(to_cell.piece)
    to_cell.clear_piece_and_content
    to_cell.update_piece_and_content(original_to_cell_piece)
  end

  def in_check_if_piece_moves?(from_cell, to_cell)
    original_to_cell_piece = to_cell.piece
    update_to_cell_and_clear_from_cell(to_cell, from_cell)
    in_check = check_manager.active_team_check?
    put_pieces_back(original_to_cell_piece, to_cell, from_cell)
    in_check
  end

  def step_1_text
    if check_manager.active_team_check?
      puts
      puts "#{game.active_team}'s turn!".underline
      puts
      puts "Oh no! Your King is in check. Move your king out of harms way!"
      puts "Enter the coordinates of your King."
    else
      puts
      puts "#{game.active_team}'s turn!".underline
      puts
      puts "Enter the coordinates of the piece you want to move."
      save_and_quit_text
    end
  end

  def step_2_text
    clear_and_print_board
    puts
    puts "#{game.active_team}'s turn!".underline
    puts
    puts "Enter the coordinates of a legal move or a piece you'd like to capture."
    puts "or type '#{'unselect'.colorize(:blue)}' to unselect your chosen piece and select a new piece to move."
  end

  def save_and_quit_text
    puts
    puts "Or type '#{'save'.colorize(:blue)}' to save your game and quit."
  end

  def invalid_from_selection_responses(cell, input)
    if cell.nil?
      clear_and_print_board
      puts
      puts 'That space was not on the board!'.underline
      puts "#{game.active_team} team, select a space on the board (a-h, 1-8)."
    elsif cell.enemy_team_on_space?
      clear_and_print_board
      puts
      puts 'That piece is not on your team!'.underline
      puts "#{game.active_team} team, select a space containing a piece of your own team."
    elsif cell.empty?
      clear_and_print_board
      puts
      puts 'There is no piece on that space!'.underline
      puts "#{game.active_team} team, select a space containing a piece of your own team."
    elsif move_manager.valid_moves_empty?(cell)
      clear_and_print_board
      puts
      puts 'This piece has no available moves!'.underline
      puts "#{game.active_team} team, select another piece that can move."
    elsif check_manager.did_not_select_checked_king?(input)
      clear_and_print_board
      puts
      puts 'Your King is in imminent danger!!!'.underline
      puts "#{game.active_team} team, select your King and move it to safety!"
    end
    save_and_quit_text
  end

  def invalid_to_selection_responses(from_cell, to_cell, input)
    valid_moves = move_manager.valid_moves_for(from_cell)
    
    if check_manager.moving_into_check?(from_cell, input)
      clear_and_print_board
      puts
      puts 'Your King cannot move there because it would be in check.'.underline
      puts "#{game.active_team} team, move your King elsewhere, select a different piece to move,"
      puts "or type '#{'unselect'.colorize(:blue)}' to unselect your chosen piece and select a new piece to move."
    elsif !valid_moves.include?(input)
      clear_and_print_board
      puts
      puts 'This is not a legal move for this piece.'
      puts "#{game.active_team} team, select a legal move for this piece"
      puts "or type '#{'unselect'.colorize(:blue)}' to unselect your chosen piece and select a new piece to move."
    elsif in_check_if_piece_moves?(from_cell, to_cell)
      clear_and_print_board
      puts
      puts "If you move here, your King will be in check!"
      puts "#{game.active_team} team, select a move for this piece that will keep your King safe"
      puts "or type '#{'unselect'.colorize(:blue)}' to unselect your chosen piece and select a new piece to move."
    end
  end

  def clear_and_print_board
    system('clear')
    board.print_board
  end

  def save_game_option(input)
    if input == 'save'
      board.fen_string = board.board_to_fen
      game.save_game
      exit
    end
  end
end