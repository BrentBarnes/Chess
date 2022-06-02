
class Queen < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♛'
    else
      '♕'
    end
  end

  def directions
    [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
  end
end
