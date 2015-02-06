require 'lib/map_cell'

class Map
  constructor: (@game, @layers) ->
    @layers = [] if @layers == undefined
  
  addLayer: (layer) ->
    @layers.push layer

  draw: ->
    for layer in @layers
      for cell in layer.cells
        @game.display.draw(cell.x, cell.y, cell.content, cell.color, cell.bgcolor)

  updateLayers: ->
    for layer in @layers
      layer.updateAttributes()
