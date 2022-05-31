
class WPawn

  def color
    "white"
  end

  def symbol
    "\u265F".encode('utf-8')
  end

  def same_team?(player1_turn)
    player1_turn ? true : false
  end

end