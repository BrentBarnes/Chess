
class EmptySpace < Piece

  def initialize(color=nil)
    @color = nil
  end

  def to_s
    ' '
  end

  def same_team?(player1_turn)
    false
  end

  def directions
    nil
  end
end