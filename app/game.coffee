require 'entities/player'
require 'maps/digger_map'
require 'entities/conservative'

class @Game
  constructor: ->
    @display = new ROT.Display()
    @map = new DiggerMap(@)

    document.body.appendChild @display.getContainer()

    @player = new Player(@, @map)

    scheduler = new ROT.Scheduler.Simple()
    scheduler.add(@player, true)

    @engine = new ROT.Engine(scheduler)
    @engine.start()

    @conservatives = []
    @conservatives.push new Conservative(@, @map) for [1..10]

    for c in @conservatives
      scheduler.add c, true 

    self = @

    @tickInterval = setInterval( () ->
      Game.tick(self)
    , 1000 / 60)

    @map.draw()

  speak: (text) ->
    alert(text)

  @tick: (game) ->
    deadConservatives = 0
    for c in game.conservatives
      if c.dead
        deadConservatives++

    if deadConservatives == game.conservatives.length
      clearInterval(game.tickInterval)
      game.speak("Everything is now Liberal!!! You Won!!")
      deadConservatives = 0

    game.map.draw()
