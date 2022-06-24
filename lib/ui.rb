
class UI
  attr_reader :game, :board, :move_manager, :check_manager

  def initialize(game, board, move_manager, check_manager)
    @game = game
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
  end

  def introduction
    system('clear')
    puts "Welcome to Chess!"
    puts
    puts "Each turn will be played in two different steps."
    puts
    puts "Step One:"
    puts "Enter the coordinates of the piece you want to move, like 'a1' or 'g7'."
    puts
    puts "Step Two:"
    puts "Enter the coordinates of any legal move or enemy piece you'd like to capture."
    puts
    puts "To begin press 1 followed by Enter."
    puts
    puts "Or type 'load' to load your previously saved game."
  end

  def step_1_text
    if check_manager.active_team_check?
      puts
      puts "#{game.active_team}'s turn!"
      puts
      puts "Oh no! Your King is in check. Move your king out of harms way!"
      puts "Enter the coordinates of your King."
    else
      puts
      puts "#{game.active_team}'s turn!"
      puts
      puts "Enter the coordinates of the piece you want to move."
      save_and_quit_text
    end
  end

  def step_2_text
    clear_and_print_board
    puts
    puts "#{game.active_team}'s turn!"
    puts
    puts "Enter the coordinates of a legal move or a piece you'd like to capture."
    puts "or type 'unselect' to unselect your chosen piece and select a new piece to move."
    save_and_quit_text
  end

  def save_and_quit_text
    puts
    puts "Or type 'save' to save your game and quit."
  end

  def game_over_text
    puts
    puts "Game Over! #{game.non_active_team} Wins!"
    puts
    puts "Would you like a rematch?"
    puts "Enter 'y' for yes, or 'n' for no."
  end

  def game_over_sequence
    system('clear')
    board.print_board
    game_over_text
    rematch = gets.chomp.downcase
    rematch == 'y' ? true : false
  end

  def invalid_from_selection_responses(cell, input)
    if cell.nil?
      clear_and_print_board
      puts
      puts 'That space was not on the board!'
      puts "#{game.active_team} team, select a space on the board (a-h, 1-8)."
    elsif cell.enemy_team_on_space?
      clear_and_print_board
      puts
      puts 'That piece is not on your team!'
      puts "#{game.active_team} team, select a space containing a piece of your own team."
    elsif cell.empty?
      clear_and_print_board
      puts
      puts 'There is no piece on that space!'
      puts "#{game.active_team} team, select a space containing a piece of your own team."
    elsif move_manager.valid_moves_empty?(cell)
      clear_and_print_board
      puts
      puts 'This piece has no available moves!'
      puts "#{game.active_team} team, select another piece that can move."
    elsif check_manager.did_not_select_checked_king?(input)
      clear_and_print_board
      puts
      puts 'Your King is in imminent danger!!!'
      puts "#{game.active_team} team, select your King and move it to safety!"
    end
    save_and_quit_text
  end

  def invalid_to_selection_responses(from_cell, to_cell, input)
    valid_moves = move_manager.valid_moves_for(from_cell)
    
    if check_manager.moving_into_check?(from_cell, input)
      clear_and_print_board
      puts
      puts 'Your King cannot move there because it would be in check.'
      puts "#{game.active_team} team, move your King elsewhere, select a different piece to move,"
      puts "or type 'unselect' to unselect your chosen piece and select a new piece to move."
    elsif !valid_moves.include?(input)
      clear_and_print_board
      puts
      puts 'This is not a legal move for this piece.'
      puts "#{game.active_team} team, select a legal move for this piece"
      puts "or type 'unselect' to unselect your chosen piece and select a new piece to move."
    elsif in_check_if_piece_moves?(from_cell, to_cell)
      clear_and_print_board
      puts
      puts "If you move here, your King will be in check!"
      puts "#{game.active_team} team, select a move for this piece that will keep your King safe"
      puts "or type 'unselect' to unselect your chosen piece and select a new piece to move."
    end
    save_and_quit_text
  end

  def move_piece
    from_cell = nil
    to_cell = nil

    loop do
      step_1_text
      from_cell = get_player_first_input
      move_manager.show_valid_moves(from_cell)
      step_2_text
      to_cell = get_player_second_input(from_cell)
      move_manager.remove_valid_moves(from_cell)
      next if to_cell == 'unselected'
      break
    end
    
    to_cell.send_piece_to_graveyard if to_cell.occupied?
    update_to_cell_and_clear_from_cell(to_cell, from_cell)
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
      save_game_option(input)
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

  def clear_and_print_board
    system('clear')
    board.print_board
  end

  def save_game_option(input)
    if input == 'save'
      game.save_game
      exit
    end
  end
end