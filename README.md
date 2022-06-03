I keep running into better and better problems, so that's a good thing!
Earlier, it was recommended to me to use overriding equivalents, and I'm trying to figure out if I'm using it right. I've made a  `MoveManager` class that will try to validate moves for each piece. I have 3 methods in it so far: `#surrounding_cells` which finds all of the cells that surround a Cell object. This uses `Cell` methods like:
```ruby
def up
  Cell.new(row - 1, column)
end
```
meaning, it creates new Cell objects with every call. Because of this, say our current Cell is 'd3',  if the previously initialized `Board` has a piece on 'd4', it will not register on this newly created Cell. `#surrounding_cells` collects these in an array and gets used in the next method: `#convert_to_board`. 
This is where I attempt to convert these new Cell objects into actual board objects by overriding equivalents.
```ruby
def convert_to_board(space_object)
    non_board = surrounding_cells(space_object)
    board_cells = []

    non_board.each do |fake_cell|
      board.board.flatten.find { |cell| board_cells << cell if cell == fake_cell }
    end
    board_cells
end
```
hypothetically, this should scan over the `Board` object and find a REAL Board cell that matches the FAKE board cell, and push that REAL cell into a new array called `board_cells` 

The third method is `#valid_king_moves`. When I test this, this is where things go wrong. It returns EVERY space that surrounds the king. However, when I place a piece above the king on 'd4' in a test, it doesn't register somewhere in the code that there's a piece on that space.

My guess is that it's because I've injected a new `Board` object into `MoveManager` that is a new object instead of a reference to the already existing board.
```ruby
def initialize(board)
  @game = Game.new
  @board = board
end
```
Is this what's causing the issue, or am I missing something? Am I overriding equivalents correctly?