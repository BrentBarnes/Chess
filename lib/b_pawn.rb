
class BPawn

  def color
    "black"
  end

  def symbol
    "\u2659".encode('utf-8')
  end

  def same_team?(player1_turn)
    player1_turn ? false : true
  end

end