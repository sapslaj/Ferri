require 'lib/map'

# Abstract class to handle map entities
class Entity
  # Takes game instance and map
  
  @type: 'entity'

  constructor: (@game, @map) ->
    freeCell = @map.findOpenCell()
    @x = freeCell.x
    @y = freeCell.y

    @oldtype = @map.at(@x, @y).type
    @oldentity = @map.at(@x, @y).entity
    @map.at(@x, @y).setType(@_type())
    @map.at(@x, @y).entity = @

  act: ->

  handleEvent: (e) ->

  updatePosition: (newX, newY) ->
    @map.at(@x, @y).setType(@oldtype)
    @map.at(@x, @y).entity = @oldentity
    @x = newX
    @y = newY
    @oldtype = @map.at(newX, newY).type
    @map.at(newX, newY).setType(@_type())
    @map.at(newX, newY).entity = @
    @map.updateCells()
    @map.draw()

  move: (diffX, diffY) ->
    newX = @x + diffX
    newY = @y + diffY
    if @_canMove(newX, newY)
      @updatePosition(newX, newY)


  _canMove: (newX, newY) ->
    @map.at(newX, newY).isFree()

  # Override this to change map type
  _type: ->
    @type

