
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
    to_row = selection_to_array_row(to)
    to_column = selection_to_array_column(to)

    if valid_space?(to) && !same_team?(to)
      if !same_team?(to) then send_piece_to_graveyard(to) end
      board.board[to_row][to_column] = from_space
      board.clear_piece(from)
    else
      puts 'Select a valid move.'
      move_piece(from=nil, to=nil)
    end
  end

  def select_space(selection=nil)
    if selection.nil? then selection = gets.chomp end

    if valid_space?(selection)
      row = selection_to_array_row(selection)
      column = selection_to_array_column(selection)
      board.board[row][column]
    else
      puts 'Select a valid coordinate.'
      select_space
    end
  end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

  def get_name_of_piece(coordinate)
    piece = get_piece_on_space(coordinate)
    @@all_pieces.each do |key, value|
      if value == piece then return key.to_s end
    end
  end

  def get_piece_on_space(coordinate)
    space = select_space(coordinate)
    space[1]
  end

  def send_piece_to_graveyard(coordinate)
    piece = get_piece_on_space(coordinate)
    if white_pieces.include?(piece)
      board.p1_graveyard << piece
    elsif black_pieces.include?(piece)
      board.p2_graveyard << piece
    end
  end

  def same_team?(selection)
    return if board.space_empty?(selection)
    piece = get_piece_on_space(selection)
    
    if white_pieces.include?(piece) && player1_turn? ||
      black_pieces.include?(piece) && !player1_turn?
      true
    else
      false
    end
  end

  def valid_space?(selection)
    row = selection_to_array_row(selection)
    column = selection_to_array_column(selection)
    if selection.length == 2 && column.between?(0,7) && row.between?(0,7)
      true
    else
      false
    end
  end

end
