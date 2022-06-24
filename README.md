I'm having what I think is a simple issue with Chess?
I'm at the stage where I'm attempting to save and load the game. Here's the code 
```ruby
  def to_json
    JSON.dump ({
      :graveyard => @graveyard,
      :board => @board,
      :move_manager => @move_manager,
      :check_manager => @check_manager,
      :ui => @ui,
      :turn => @turn
    })
  end

  def from_json(string)
    data = JSON.load string
    data
    @graveyard = data["graveyard"]
    @board = data["board"]
    @move_manager = data["move_manager"]
    @check_manager = data["check_manager"]
    @ui = data["ui"]
    @turn = data["turn"]
  end

  def save_game
    save_file = File.open("save_file.txt", "w")
    save_file.write to_json
    save_file.close
  end

  def load_game
    file = File.open("save_file.txt", "r")
    contents = file.read

    from_json(contents)
  end
```
However, my `save_file.txt` saves all of my instance variables as strings. When I try to load these back in, the objects have become strings and they cannot perform the methods inside of them.

I have a feeling it has something to do with how I'm getting the data back, i.e. `def from_json` I tried to take the quotations off so it said `data[graveyard]` for example, and I tried another thing or two, but nothing has has worked. I basically stole this from my hangman project, but the instance variables I had in hangman weren't as complex as objects.
Does anybody have any insight they can offer here?