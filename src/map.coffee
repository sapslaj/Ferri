require 'lib/map_cell'

class Map
  constructor: (@game) ->
    @cells = []
    @_generate()

  indexOf: (x, y) ->
    @cells.indexOf(@at(x, y))

  at: (x, y) ->
    for cell in @cells
      if cell.x == x and cell.y == y
        return cell

  draw: ->
    for cell in @cells
      @game.display.draw(cell.x, cell.y, cell.content, cell.color)

  findOpenCell: ->
    min = 0
    max = @cells.length
    freeCell = {}
    freeCell = @cells[Math.floor(Math.random() * (max - min) + min)] while freeCell.type != 'free'
    freeCell

  addCell: (x, y, type) ->
    if y == undefined
      @cells.push x
    else
      @cells.push(new MapCell(x, y, type))

  updateCells: ->
    for cell in @cells
      cell.updateAttributes()

  _generate: ->
    @_create(ROT.Map.Arena(ROT.DEFAULT_WIDTH, ROT.DEFAULT_HEIGHT))

  _create: (mapGen, callback) ->
    self = @
    callback = @_generateCallback if callback == undefined

    mapGen.create (x, y, wall) -> callback(self, x, y, wall)

  _generateCallback: (map, x, y, wall) ->
    type =
      if wall
        'wall'
      else
        'free'

    map.addCell(x, y, type)
