
require_relative 'main'

class WhiteTeam

  def pieces
    [
    Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'),
    Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'),
    Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'),
    King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')
    ]
  end

end