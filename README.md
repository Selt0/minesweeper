# Minesweeper in Ruby

Launch minesweeper in your terminal (ruby required) with the game.rb file

```ruby
ruby game.rb
```

Default game is a small board (9x9) with 10 bombs

Create a new game with different layouts!

| **Layouts** | **Grid Size** | **Bombs** |
| ----------- | ------------- | --------- |
| small       | 9 x 9         | 10        |
| medium      | 16 x 16       | 40        |
| large       | 32 x 32       | 160       |

```ruby
  new_game = Minesweeper.new(:large).play
```

160 bombs! crazy!

Every round, until the game is over, enter an action move followed by the position on the board

```ruby
e 0 0
```

```ruby
f 0 1
```

_P.S The game includes a save feature :D_
