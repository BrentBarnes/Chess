
class EmptySpace < Piece

  def initialize(color=nil)
    @color = nil
  end

  def to_s
    ' '
  end

  def directions
    nil
  end
end