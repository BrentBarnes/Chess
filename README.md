So, I've been able to load in the board, but now it's the other instance variables that are being loaded in as strings.

Josh said that you don't actually have to save the statee of every instance variable that the game has.
You only need to save the state of the variables that matter. 
In my case, 
1. I need a FEN representation of the board
2. A representation of the graveyard
3. The turn variable (which takes care of itself since it's stored in the Game class)

With the board, I saved the FEN representation to @board_fen just as the player saves the game.
(Maybe I should move this saving somewhere else)
(Maybe I should save this to @board instead of having an extra @board_fen instance variable)
Then when the player chooses to load the game, this happens:

if response == 'load'
      old_game = Game.load_game
      old_game.board_from_fen
      old_game.play

So the new instance of the game is given the variable old_game
That game instance then builds the board_from_fen
and the game is able to be played.

That is until it gets to graveyard.
I will need to remove the loading of all instance variables here: 

def to_json
    JSON.dump ({
      :graveyard => @graveyard,
      :board => @board,
      :move_manager => @move_manager,
      :check_manager => @check_manager,
      :ui => @ui,
      :turn => @turn,
      :board_fen => @board_fen
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data['graveyard'], data['board'], data['move_manager'],
      data['check_manager'], data['ui'], data['turn'], data['board_fen'])
  end

  and the only ones I should need are @board (once I get rid of @board_fen), graveyard, and turn.
  I might have to use keyword arguments like graveyard: :data['graveyard']

  I will do the same process as @board for @graveyard
  When the game saves, I will update Game's @graveyard instance variable using a method called save_graveyard.
  That will make a nested array that looks like this:
  [[white graveyard goes here], [black graveyard goes here]]

  Then when the game loads, I will have a method called load_graveyard that:
  Sets the @graveyard instance variable to a new instance of Graveyard
    @graveyard = Graveyard.new(self, graveyard[0], graveyard[1])
    (Above, graveyard[0] should correspond to [white graveyard goes here], and graveyard[1] = [black graveyard goes here])

I should then be able to call old_game.load_graveyard here:
if response == 'load'
      old_game = Game.load_game
      old_game.load_graveyard
      old_game.board_from_fen
      old_game.play

and hopefully all shall be well. I could also create a method that loads the graveyard and the board like:

Game
def self.load_instance_variable_elements
  self.load_graveyard
  self.board_from_fen
end

and turn it to 

if response == 'load'
      old_game = Game.load_game
      old_game.load_instance_variable_elements
      old_game.play

Hopefully this should work!!
(unless turn decides to give me grief, but I don't think it will.)