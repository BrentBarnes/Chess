
class Pawn < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♟'
    else
      '♙'
    end
  end

  def directions
    if color == 'white'
      [[0,-1],[0,-2],[-1,-1],[1,-1]]
    else
      [[0,1],[0,2],[-1,1],[1,1]]
    end
  end
end
