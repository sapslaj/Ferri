require 'lib/entity'

class Player extends Entity
  act: ->
    @game.engine.lock()
    window.addEventListener('keydown', @)

  handleEvent: (e) ->
    code = e.keyCode

    return @attack() if code == ROT.VK_F

    keymap = {
      37: 3, # Left
      38: 0, # Up
      39: 1, # Right
      40: 2  # Down
    }

    code = e.keyCode
    diff = ROT.DIRS[4][keymap[code]]
    return if diff == undefined
    newX = @x + diff[0]
    newY = @y + diff[1]

    if @_canMove(newX, newY)
      @updatePosition(newX, newY)
      @game.engine.unlock()

  attack: ->
    attacks = 0
    for d in ROT.DIRS[4]
      if @map.at(@x + d[0], @y + d[1]).type == 'conservative'
        attacks += 1
        alert("You attack the Conservative swine.")
        @map.at(@x + d[0], @y + d[1]).entity.die()

    if attacks == 0
      alert("There are no Conservatives to attack right now :(")

  _type: ->
    'player'
