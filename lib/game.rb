
require 'pry'
require_relative 'miscellaneous'
require_relative 'valid_piece_moves'
require_relative 'board'

class Game
  include Miscellaneous
  include ValidPieceMoves

  attr_accessor :board, :turn

  def initialize(board)
    @board = board
    @turn = 1
  end

  def move_piece(from=nil, to=nil)
    if from.nil? then from = gets.chomp end
    if to.nil? then to = gets.chomp end

    from_space = select_space(from)
    to_space = select_space(to)

    if valid_from_selection?(from) && valid_to_selection?(to)
      if !same_team?(to) then send_piece_to_graveyard(to) end
      to_space.content = from_space.content
      from_space.clear_piece
    else
      puts 'Select a valid move.'
      move_piece(from=nil, to=nil)
    end
  end

  def select_space(coordinate=nil)
    if coordinate.nil? then coordinate = gets.chomp end
    
    if valid_board_space?(coordinate)
      board.board.flatten.find { |space| space.name == coordinate }
    else
      puts 'Select a valid coordinate (a-h followed by 1-8)'
      select_space
    end
  end

  def valid_from_selection?(selection)
    return false if !valid_board_space?(selection)
    space = select_space(selection)
    if same_team?(selection) && !space.space_empty?
      true
    else
      false
    end
  end

  def valid_to_selection?(selection)
    return false if !valid_board_space?(selection)
    space = select_space(selection)
    !same_team?(selection) || space.space_empty? ? true : false
  end

  def valid_board_space?(selection)
    return false if selection.length != 2
    return false if !selection[0].between?('a','h')
    return false if !selection[1].between?('1','8')
    true
  end

  def same_team?(coordinate)
    space = select_space(coordinate)
    piece = space.get_piece_on_space

    if white_pieces.include?(piece) && player1_turn? ||
      black_pieces.include?(piece) && !player1_turn?
      true
    elsif white_pieces.include?(piece) && !player1_turn? ||
      black_pieces.include?(piece) && player1_turn?
      false
    elsif space.space_empty?
      'empty'
    end
  end

  def send_piece_to_graveyard(coordinate)
    piece = select_space(coordinate).get_piece_on_space
    if white_pieces.include?(piece)
      board.p1_graveyard << piece
    elsif black_pieces.include?(piece)
      board.p2_graveyard << piece
    end
  end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

end
