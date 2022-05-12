# Chess

I'm continuing to work on my chess project and I've run into another design issue. I've refactored my program to include a Coordinate class. This class keeps track of everything on a single space in the game including if there is a piece on there and all of its surrounding neighbor pieces.

I'm moving on to the next phase of the project where I build the valid moves for each piece type. I wanted to design it so that my Coordinate object could get the type of piece, then, based on that, it could generate all of its valid moves into an array. However, this coordinate class doesn't have access to the methods that I need it to have access to! 

My design so far is a Game class that's injected with a Board object, and that Board object is injected with 64 individual Coordinate objects. My Game class has essential methods like selecting a space and returning its object. Once I've selected the space, I can play with all of its variables and such. I also have all of my methods that determine whether a move is valid like a `same_team` method that determines whether the piece is a friend or foe.

I THINK I need these in my Coordinate class, but I don't know if that will be possible. My options that I saw was to move these needed methods into a module, but that broke everything, and I don't know if it's the best route to go. I also think I could build another class or module called `ValidMoves` but even then, I don't know where to put that. Could I make a `ValidMoves` module and include it in the Game class so that it can also have access to everything in other injected objects? I can't tell if that's abusing modules, or if I'm just totally off track. It feels like I'm trying to brute force a solution to this when it's really a design flaw somewhere in the system. Could anyone lend some insight?

My repo: https://github.com/BrentBarnes/Chess