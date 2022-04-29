

module ValidPieceMoves

  def w_pawn_valid_moves(coordinate)
    valid_moves = []
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)
    
    up = array_to_chess_coord(row-1,column)
    if valid_space?(up) && board.space_empty?(up)
      valid_moves << up 
    end
    
    two_up = array_to_chess_coord(row-2,column)
    if valid_space?(two_up) &&
      board.space_empty?(up) && 
      board.space_empty?(two_up) &&
      row == 6
      valid_moves << two_up
    end

    up_left = array_to_chess_coord(row-1,column-1)
    if valid_space?(up_left) &&
      !same_team?(up_left) &&
      !board.space_empty?(up_left)
      valid_moves << up_left
    end
    
    up_right = array_to_chess_coord(row-1,column+1)
    if valid_space?(up_right) && 
      !same_team?(up_right) && 
      !board.space_empty?(up_right)
      valid_moves << up_right
    end
    valid_moves
  end

  def b_pawn_valid_moves(coordinate)
    valid_moves = []
    
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)
    
    down = array_to_chess_coord(row+1,column)
    if valid_space?(down) && board.space_empty?(down)
      valid_moves << down 
    end
    
    two_down = array_to_chess_coord(row+2,column)
    if valid_space?(two_down) &&
      board.space_empty?(down) && 
      board.space_empty?(two_down) &&
      row == 1
      valid_moves << two_down
    end

    down_left = array_to_chess_coord(row+1,column-1)
    if valid_space?(down_left) &&
      !same_team?(down_left) &&
      !board.space_empty?(down_left)
      valid_moves << down_left
    end

    down_right = array_to_chess_coord(row+1,column+1)
    if valid_space?(down_right) && 
      !same_team?(down_right) && 
      !board.space_empty?(down_right)
      valid_moves << down_right
    end
    valid_moves
  end

  def rook_valid_moves(coordinate)
    valid_moves = []
    
    row = selection_to_array_row(coordinate)
    column = selection_to_array_column(coordinate)
    
  end

  def move_up(current_space, valid_moves=[])
    row = selection_to_array_row(current_space)
    column = selection_to_array_column(current_space)
    next_space = array_to_chess_coord(row-1, column)
    return if !same_team?(current_space) && !board.space_empty?(current_space)

    if  valid_space?(next_space) && !same_team?(next_space)
      valid_moves << next_space
      move_up(next_space, valid_moves)
    end
    valid_moves
  end

  def array_to_chess_coord(row, column)
    chess_row = (1 + (7 - row)).to_s
    chess_column = (column + 97).chr
    chess_column + chess_row
  end

end
