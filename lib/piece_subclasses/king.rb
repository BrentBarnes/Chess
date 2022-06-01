
class King < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♚'
    else
      '♔'
    end
  end
    
    def moves
      [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
    end
end
