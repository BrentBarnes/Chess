
require_relative 'main'

class Board

  attr_accessor :board, :cell, :p1_graveyard, :p2_graveyard, :fen_string
  attr_reader :game, :graveyard, :move_manager

  def initialize(game, graveyard, move_manager, fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
    @game = game
    @fen_string = fen_string
    @board = create_board
    @graveyard = graveyard
  end

  def set_up_board
    # create_board
    # set_pieces_on_board
  end

  def create_board
    i = 0
    array = Array.new(8) {Array.new(8)}
    array.each_with_index do |row, row_index|
      row.each_with_index do |space, column_index|
        array[row_index][column_index] = Cell.new(row_index, column_index, game, self)
        array[row_index][column_index].cell_from_fen(fen_to_pieces[i])
        i += 1
      end
    end
  end

  def fen_to_pieces
    piece_array = []

    fen_string.each_char do |fen|
      case
      when fen == 'K'
        piece_array << King.new('white')
      when fen == 'k'
        piece_array << King.new('black')
      when fen == 'Q'
        piece_array << Queen.new('white')
      when fen == 'q'
        piece_array << Queen.new('black')
      when fen == 'R'
        piece_array << Rook.new('white')
      when fen == 'r'
        piece_array << Rook.new('black')
      when fen == 'N'
        piece_array << Knight.new('white')
      when fen == 'n'
        piece_array << Knight.new('black')
      when fen == 'B'
        piece_array << Bishop.new('white')
      when fen == 'b'
        piece_array << Bishop.new('black')
      when fen == 'P'
        piece_array << Pawn.new('white')
      when fen == 'p'
        piece_array << Pawn.new('black')
      when fen == '/'
        
      when fen.between?('1', '8')
        fen.to_i.times do
          piece_array << EmptySpace.new('none')
        end
      end
    end
    piece_array
  end

  def print_board
    
    rows = ""
    
    graveyard.display_graveyard('white')
    puts "   a  b  c  d  e  f  g  h"
    row_number = 8
    board.each_with_index do |row, row_index|
      rows << "#{row_number.to_s} "
      row.each_with_index do |space, column_index|
        if row_index % 2 == 0 && column_index % 2 == 0 ||
           row_index % 2 == 1 && column_index % 2 == 1
           rows << space.content
        else
          rows << space.content
        end
      end
      rows << " #{row_number.to_s}\n"
      row_number -= 1
    end
    puts rows
    puts "   a  b  c  d  e  f  g  h"
    graveyard.display_graveyard('black')
  end

  def cell_at(coordinate)
    board.flatten.find { |space| space.name == coordinate }
  end

  def get(x,y)
    board.flatten.find { |space| space.column == x && space.row == y } || NullCell.new
  end

  def in_bounds?(coordinate)
    valid_length = coordinate.length == 2
    valid_row = coordinate[0].between?('a','h')
    valid_column = coordinate[1].between?('1','8')
    valid_length && valid_row && valid_column ? true : false
  end
  
  def set_pieces_on_board
    white_team = WhiteTeam.new
    black_team = BlackTeam.new

    i = 0
    while i < 16
      place_piece(white_team.pieces[i], white_starting_spaces[i])
      place_piece(black_team.pieces[i], black_starting_spaces[i])
      i += 1
    end
  end

  def place_piece(piece_object, coordinate)
    space = cell_at(coordinate)
    space.update_piece_and_content(piece_object)
  end

  def black_starting_spaces
    ['a8','b8','c8','d8','e8','f8','g8','h8',
    'a7','b7','c7','d7','e7','f7','g7','h7']
  end

  def white_starting_spaces
    ['a2','b2','c2','d2','e2','f2','g2','h2',
    'a1','b1','c1','d1','e1','f1','g1','h1']
  end

  def find_king(friendly_or_enemy)
    board.flatten.find do |space| 
      if game.player1_turn? && friendly_or_enemy == 'enemy' ||
         !game.player1_turn? && friendly_or_enemy == 'friendly'
        space.content.uncolorize == ' ♔ '
      else
        space.content.uncolorize == ' ♚ '
      end
    end
  end

  def active_king_on_cell?(cell_object)
    piece_on_cell = cell_object.piece
    king_on_space = piece_on_cell.is_a? King
    piece_color = piece_on_cell.color
    active_team = game.active_team.downcase

    king_on_space && piece_color == active_team
  end

  def find_pieces(friendly_or_enemy)
    if friendly_or_enemy == 'friendly'
    cells = board.flatten.filter_map { |cell| cell if cell.same_team_on_space? }
    else
      cells = board.flatten.filter_map { |cell| cell if cell.enemy_team_on_space? }
    end
    cells.sort_by(&:name)
  end

  def board_to_fen
    array = []
    counter = 0

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        fen = cell.cell_to_fen

        if fen == 'empty'
          counter += 1
        end
        if fen != 'empty' && counter > 0
          array << counter.to_s
          counter = 0
        end
        if fen != 'empty'
          array << cell.cell_to_fen
        end
      end
      if counter > 0
        array << counter
        counter = 0
      end
      array << '/'
    end
    # @fen_string = array.join.chop
    # game.board_fen = array.join.chop
    array.join.chop
  end

  # def self.board_from_fen(fen_string)
  #   create_board
  # end
end
