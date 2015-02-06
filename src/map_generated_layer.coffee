class MapGeneratedLayer extends MapLayer
  constructor: () ->
    super
    @_generate()

  findOpenCell: ->
    min = 0
    max = @cells.length
    freeCell = {}
    freeCell = @cells[Math.floor(Math.random() * (max - min) + min)] while !freeCell.isFree()
    freeCell

  _generate: ->
    @create(ROT.Map.Arena(ROT.DEFAULT_WIDTH, ROT.DEFAULT_HEIGHT)

  _create: (mapGen, callback) ->
    self = @
    callback = @_generationCallback if callback == undefined
    
    mapGem.create (x, y, wall) -> callback(self, x, y, wall)

  _generationCallback: (map, x, y, wall) ->
    type = 
      if wall
        'wall'
      else
        'free'

    map.addCell(x, y, type)
