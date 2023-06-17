require "./game"

game = Game.new(10, 10)
print "\033[2J\033[0;0H"
game.display
while true do
  game.next_turn
end

