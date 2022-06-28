
class RedBackground < Piece

  def initialize(color)
    @color = 'red'
  end

  def to_s
    "   ".colorize(background: :red)
  end

  def directions

  end
end
