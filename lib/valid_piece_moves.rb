
module ValidPieceMoves

  def valid_pawn_moves(coordinate)
    valid_moves = []
    space = space_at(coordinate)

    if white_pieces.include?(space.get_piece_on_space)
      forward = space_at(space.up)
      forward_2 = space_at(forward.up)
      enemy_left = space_at(space.up_left)
      enemy_right = space_at(space.up_right)
    elsif black_pieces.include?(space.get_piece_on_space)
      forward = space_at(space.down)
      forward_2 = space_at(forward.down)
      enemy_left = space_at(space.down_left)
      enemy_right = space_at(space.down_right)
    end

    if forward.space_empty? then valid_moves << forward.name end
    if forward.space_empty? && forward_2.space_empty? then valid_moves << forward_2.name end
    
    if !same_team?(enemy_left.name) && !enemy_left.space_empty? then valid_moves << enemy_left.name end
    if !same_team?(enemy_right.name) && !enemy_right.space_empty? then valid_moves << enemy_right.name end 

    valid_moves
  end

  def valid_rook_moves(coordinate)
    x = [0,1,0,-1]
    y = [1,0,-1,0]
    valid_moves = []
    
    4.times do |i|
      valid_moves << valid_moves_in_direction(coordinate, x[i], y[i])
    end
    valid_moves.flatten
  end

  def valid_queen_moves(coordinate)
    x = [0,1,1,1,0,-1,-1,-1]
    y = [1,1,0,-1,-1,-1,0,1]
    valid_moves = []
    
    8.times do |i|
      valid_moves << valid_moves_in_direction(coordinate, x[i], y[i])
    end
    valid_moves.flatten
  end

  def valid_bishop_moves(coordinate)
    x = [1,1,-1,-1]
    y = [1,-1,-1,1]
    valid_moves = []
    
    4.times do |i|
      valid_moves << valid_moves_in_direction(coordinate, x[i], y[i])
    end
    valid_moves.flatten
  end

  def valid_moves_in_direction(space, x_adj, y_adj)
    current = space_at(space)
    all_spaces = current.all_spaces_in_direction(space, x_adj, y_adj)
    next_space = space_at(all_spaces[0])
    valid_spaces = []
    
    i = 0
    until i >= all_spaces.length || !same_team?(current.name) || same_team?(next_space.name) == true
      valid_spaces << next_space.name
      i += 1
      current = next_space
      if i < all_spaces.length then next_space = space_at(all_spaces[i]) end
    end
    valid_spaces
  end

  def valid_knight_moves(space)
    current = space_at(space)
    x = [-1,1,2,2,1,-1,-2,-2]
    y = [2,2,1,-1,-2,-2,-1,1]
    valid_moves = []

    8.times do |i|
      new_space = current.alter_name(space, x[i], y[i])
      valid_moves << new_space unless same_team?(new_space) == true
    end
    valid_moves
  end

  def valid_king_moves(space)
    current = space_at(space)
    x = [0,1,1,1,0,-1,-1,-1]
    y = [1,1,0,-1,-1,-1,0,1]
    valid_moves = []

    8.times do |i|
      new_space = current.alter_name(space, x[i], y[i])
      valid_moves << new_space unless same_team?(new_space) == true
    end
    valid_moves
  end

  def array_to_chess_coord(row, column)
    chess_row = (1 + (7 - row)).to_s
    chess_column = (column + 97).chr
    chess_column + chess_row
  end

end
