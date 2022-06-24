J
the call to #set_up_board is reached whether or not the player chooses to load a game. break won't break out of the method entirely, just out the that loop it's in. Bad news is if you fix this, you'll immediately run into another issue: the state of the objects the board holds a reference to aren't automatically serialized just because you serialize the board instance variable in Game. You'll need to come up with some way to persist this information. There are some domain specific options you can research by looking into "chess notation"


B
So step 1 (saving): if I were to use FEN for example, I could build a to_fen method in my Cell class so that each cell could translate itself into fen. Then I could iterate through the board, converting each cell to fen, and serialize that?

Step 2 (loading): I will have to load in the array of fen cells, and make a from_fen method that can then iterate through the array of fen cells to convert them back into Cell objects to build the board with? 

I think I can get myself through converting to a notation type and converting it back, but I don't know if I'll know how to serialize just that information, and then how to access that information and use it to populate the board again upon loading.
Will I have to build board_to_json and board_from_json methods in the board class or something


J
Basically rather than the template of saving where you have 
key: @instance_var, you can say key: @object.to_fen 
or something. and then a from_fen call on the other side
So what's getting saved is the notation, not the board directly. The board would be capable of converting its state to some notation and then loading its state from some notation


B
okay, so the board converts it to a fen_array or something like that, then I can call something like 

def to_json
    JSON.dump ({
      :board =>@board.to_fen
      #plus more below
    })
  end


and then I would load it back in somewhere in here?

def self.from_json(string)
    data = JSON.load string
    #below doesn't seem right
    self.new(data['board.from_fen'], #etc..... )
  end


J
  Yep, only probably in the bottom one it'd be like data['board'].from_fen -- fetching the object at the key 'board' and then call the method on it