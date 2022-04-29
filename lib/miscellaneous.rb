
module Miscellaneous

  @@w_queen = "\u265B".encode('utf-8')
  @@w_king = "\u265A".encode('utf-8')
  @@w_rook = "\u265C".encode('utf-8')
  @@w_bishop = "\u265D".encode('utf-8')
  @@w_knight = "\u265E".encode('utf-8')
  @@w_pawn = "\u265F".encode('utf-8')

  @@b_queen = "\u2655".encode('utf-8')
  @@b_king = "\u2654".encode('utf-8')
  @@b_rook = "\u2656".encode('utf-8')
  @@b_bishop = "\u2657".encode('utf-8')
  @@b_knight = "\u2658".encode('utf-8')
  @@b_pawn = "\u2659".encode('utf-8')

  @@all_pieces = {
    w_queen: "\u265B".encode('utf-8'), 
    w_king: "\u265A".encode('utf-8'),
    w_rook: "\u265C".encode('utf-8'),
    w_bishop: "\u265D".encode('utf-8'),
    w_knight: "\u265E".encode('utf-8'),
    w_pawn: "\u265F".encode('utf-8'),
    b_queen: "\u2655".encode('utf-8'),
    b_king: "\u2654".encode('utf-8'),
    b_rook: "\u2656".encode('utf-8'),
    b_bishop: "\u2657".encode('utf-8'),
    b_knight: "\u2658".encode('utf-8'),
    b_pawn: "\u2659".encode('utf-8')
  }

  def create_piece(color_letter, piece_name)
    string = color_letter + '_' + piece_name
    piece = @@all_pieces.fetch(string.to_sym)
  end

  def white_pieces
    [@@w_king, @@w_queen, @@w_rook, @@w_bishop, @@w_knight, @@w_pawn]
  end

  def black_pieces
    [@@b_king, @@b_queen, @@b_rook, @@b_bishop, @@b_knight, @@b_pawn]
  end

  def selection_to_array_row(letter)
    split = letter.split('')
    row = 7 - (split[1].to_i - 1)
  end

  def selection_to_array_column(number)
    split = number.split('')
    column = split[0].ord - 97
  end
end