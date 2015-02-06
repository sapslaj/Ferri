require 'lib/entity'

class Conservative extends Entity
  act: ->
    unless @dead
      if ROT.RNG.getPercentage() < 50
        direction = ROT.DIRS[4].random()
        @move(direction[0], direction[1])

  die: ->
    @map.at(@x, @y).setType(@oldtype)
    @dead = true

  _type: -> 'conservative'
