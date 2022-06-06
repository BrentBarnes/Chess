I've run into a nil issue with Chess about checking if a space is out of bounds.  I've built methods in my Cell class so that it can know the cell objects around it. These methods are called "up, up_right, right, down_right, etc." When a Cell tries to retrieve a Cell that is out of bounds, the directional methods like `#up` returns nil, and it breaks the `#valid_moves` methods that use these directional methods. 

I've been able to get around this when it comes to all of my pieces besides a knight because the knight is the only piece that I've attempted chaining these directional methods together. i.e. `up.up.right` would give me the knight's first potential cell. I was able to solve it using the safe navigation operator like so:
```ruby
directions = [up&.up&.right, right&.right&.up, right&.right&.down, down&.down&.right,
                  down&.down&.left, left&.left&.down, left&.left&.up, up&.up&.left]
```
but I don't know if this is okay to do. I feel like having to use the safe navigation operator in this way is convenient, but it might point back to a bigger issue in the codebase somewhere? Maybe there's a place I can check if the next space is nil before it gets to this point? I've tried adding guard statements in multiple methods like `#board.get` and the directional methods, so that if the result is nil, it returns. But this hasn't worked so far. 

I could also avoid this by creating a method like:
```ruby
def knight_up_right
  board.get(x + 1, y - 2)
end
```
the same way I did for the other direction methods. However, this would create 8 more methods inside of Cell class JUST for the knight. I feel like I should be able to chain these together somehow, but I'm missing a guard statement somewhere or some kind of simple fix that checks for nil in the perfect place before it can ruin everything!
My repo: https://github.com/BrentBarnes/Chess/tree/oo_refactor